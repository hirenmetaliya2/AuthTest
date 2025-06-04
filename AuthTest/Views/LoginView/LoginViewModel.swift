//
//  LoginViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI


class LoginViewModel: ObservableObject{
    @Published var errorMessage: String?
    @Published var tokens: Tokens?
    @Published var email: String = "user@1.com"
    @Published var password: String = "str"
    
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
    
    
}
