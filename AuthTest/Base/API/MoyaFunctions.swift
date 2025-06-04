//
//  MoyaFunctions.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation
import Moya

struct MoyaFunctions{
    func createMoyaProvider() -> MoyaProvider<Endpoints> {
        var config = NetworkLoggerPlugin.Configuration()
        let requestClosure = makeRequestClosure()
            config.logOptions = [NetworkLoggerPlugin.Configuration.LogOptions.successResponseBody, NetworkLoggerPlugin.Configuration.LogOptions.requestMethod, NetworkLoggerPlugin.Configuration.LogOptions.errorResponseBody, NetworkLoggerPlugin.Configuration.LogOptions.requestBody]

        config.output = logNetwork
        let provider = MoyaProvider<Endpoints>(requestClosure: requestClosure, plugins: [NetworkLoggerPlugin(configuration: config)])
        return provider
    }
    
    public func logNetwork(target: TargetType, items: [String]) {
        print("\(target.method) \(target.baseURL)\(target.path)")
        items.forEach{print($0)}
    }
    
    func makeRequestClosure() -> MoyaProvider<Endpoints>.RequestClosure {
        let requestClosure = { ( endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            do{
                var request = try endpoint.urlRequest()
                
                if let token = endpoint.httpHeaderFields?["Authorization"] {
                    let bearerToken = token.replacingOccurrences(of: "Bearer ", with: "")
                    print("bearerToken: \(bearerToken)")
                    let expiry = try tokenTimestamp(of: bearerToken)
                        if Date()>=expiry.addingTimeInterval(-10){
                            getNewAccessToken{ error in
                                if let error = error{
                                    done(.failure(MoyaError.requestMapping(error.localizedDescription)))
                                }else{
                                    request.addValue("Bearer \(AuthManager.shared.tokens?.accessToken ?? "")", forHTTPHeaderField: "Authorization")
                                    done(.success(request))
                                }
                            }
                        }else{
                            done(.success(request))
                        }
                }else{
                    done(.success(request))
                }
            }
            catch{
                done(.failure(MoyaError.requestMapping(error.localizedDescription)))
            }
        }
        return requestClosure
    }
    
    func getNewAccessToken(completion: @escaping (Error?) -> Void) {
        provider.request(.getTokens(request: AuthManager.shared.tokens?.refreshToken ?? "")){ response in
            switch response{
            case .success(let value):
                do{
                    let tokens = try JSONDecoder().decode(Tokens.self, from: value.data)
                    AuthManager.shared.tokens = tokens
                    AuthManager.shared.saveTokens(tokens)
                    completion(nil)
                }catch{
                    print("Decoding error: \(error)")
                    completion(error)
                }
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }
    
//    func performRequestWithRetry(target: Endpoints, completion: @escaping (Result<Response, MoyaError>) -> Void){
//        provider.request(target){ response in
//            switch response{
//            case .success(let response):
//                if response.statusCode == 401{
//                    self.getNewAccessToken{ success in
//                        if success{
//                            provider.request(target, completion: completion)
//                        } else{
//                            completion(.failure(MoyaError.statusCode(response)))
//                        }
//                    }
//                }else{
//                    completion(.success(response))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    func tokenTimestamp(of accessToken: String) throws -> Date{
        let parts = accessToken.components(separatedBy: ".")
        
        guard parts.count == 3 else {
            throw Errors.invalidToken
        }
        
        let payloadPart = parts[1]
        var base64 = payloadPart
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        
        if let data = Data(base64Encoded: base64),
           let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let exp = json["exp"] as? TimeInterval{
            let expiryDate = Date(timeIntervalSince1970: exp)
            return expiryDate
        }else{
            throw Errors.invalidToken
        }
    }
}
