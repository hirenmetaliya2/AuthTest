//
//  Login.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//
import Foundation
import Moya


public typealias Parameters = [String: Any]
enum Endpoints{
    case login(request: Parameters)
    case signup(request: Parameters)
    case readUsers
    case getTokens(request: String)
}

var provider = MoyaFunctions().createMoyaProvider()

extension Endpoints: TargetType {
    var baseURL: URL {
        return  URL(string:"http://192.168.1.9:8000")!
    }
    
    var path: String {
        switch self{
        case .login:
            return "auth/login"
        case .signup:
            return "auth/register"
        case .readUsers:
            return "/users/me"
        case .getTokens:
            return "/auth/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .login,
            .signup:
            return .post
        case .readUsers:
            return .get
        case .getTokens:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .login(let request),
            .signup(let request):
            return .requestParameters(parameters: request, encoding: JSONEncoding.default)
        case .readUsers:
            return .requestPlain
        case .getTokens(let request):
            return .requestParameters(parameters: ["refresh_token": request], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .login,
                .signup:
            return ["Content-Type": "application/json"]
        case .readUsers:
            let token = AuthManager.shared.tokens?.accessToken ?? ""
            print("Access Token Being Used: \(token)")
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(token)"]
        case .getTokens:
            return ["Content-Type": "application/json"]
            
//        case .readUsers:
//            return nil
        }
    
    }
}
