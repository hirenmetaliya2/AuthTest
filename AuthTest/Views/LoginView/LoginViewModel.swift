//
//  LoginViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI
import Moya

class LoginViewModel: ObservableObject{
    @Published var errorMessage: String?
    @Published var tokens: Tokens?
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login(authManager: AuthManager) {
        let parameters = ["email": email, "password": password]
        provider.request(.login(request: parameters)){ result in
            switch result{
            case .success(let response):
                do{
                    let decodedResponse = try JSONDecoder().decode(Tokens.self, from: response.data)
                    
                    DispatchQueue.main.async{
                        self.tokens = decodedResponse
                        authManager.tokens = decodedResponse
                        authManager.saveTokens(decodedResponse)
                    }
                }catch{
                    self.errorMessage = error.localizedDescription
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func tokenTimestamp() throws -> Date{
        guard let jwt = tokens?.accessToken else {throw Errors.missingAccessToken}
        let parts = jwt.components(separatedBy: ".")
        let payloadPart = parts[1]
        let base64 = payloadPart
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
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
