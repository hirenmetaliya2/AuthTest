//
//  RegisterViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var signupStatus: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signup(){
        let parameters = ["email": email, "password": password]
        provider.request(.signup(request: parameters)){ result in
            switch result{
            case .success:
                self.signupStatus = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
