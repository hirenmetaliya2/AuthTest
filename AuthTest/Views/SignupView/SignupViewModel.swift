//
//  RegisterViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation

class SignupViewModel: ObservableObject {
    var baseURL = "http://192.168.1.22:8000"
    @Published var errorMessage: String?
    @Published var signupStatus: Bool = false
    
    func signup(email: String, password: String){
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
