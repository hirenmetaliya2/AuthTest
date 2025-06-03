//
//  LoginViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI
import Moya

class LoginViewModel: ObservableObject{
    @Published var isLogin: Bool = false
    @Published var errorMessage: String?
    @Published var tokens: Tokens?
    
    func login(email: String, password: String) {
        let parameters = ["email": email, "password": password]
        provider.request(.login(request: parameters)){ result in
            switch result{
            case .success(let response):
                do{
                    let decodedResponse = try JSONDecoder().decode(Tokens.self, from: response.data)
                    self.tokens = decodedResponse
                    DispatchQueue.main.async{
                        self.isLogin = true
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
