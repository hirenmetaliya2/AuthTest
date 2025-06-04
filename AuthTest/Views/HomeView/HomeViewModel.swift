//
//  HomeViewModel.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 03/06/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var errorMessage: String?
//    let moya = MoyaFunctions()
    @State var newTokens: Tokens?
    @Published var userData : User?
    
//    func fetchData() {
//        errorMessage = nil
////        moya.performRequestWithRetry(target: .readUsers){ result in
////            switch result{
////            case .success(let value):
////                do{
////                    let data = try JSONDecoder().decode(User.self, from: value.data)
////                    self.userData = data
////                }catch{
////                    print("error while decoding: \(error)")
////                }
////            case .failure(let error):
////                self.errorMessage = error.localizedDescription
////            }
////        }
//    }
    func fetchUserData(){
        provider.request(.readUsers){ result in
            switch result{
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(User.self, from: response.data)
                    self.userData = data
                }catch{
                    print("Error while decoding: \(error)")
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
    
    
}
