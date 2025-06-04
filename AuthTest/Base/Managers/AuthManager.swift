//
//  AuthManager.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject{
    static let shared = AuthManager()
    
    @Published var tokens: Tokens? = nil
    
    private init(){
        if let savedTokens = loadTokens(){
            self.tokens = savedTokens
        }
    }
    
    func loadTokens() -> Tokens?{
        if let decodedData = UserDefaults.standard.data(forKey: "tokens"){
            return try? JSONDecoder().decode(Tokens.self, from: decodedData)
        }
        return nil
    }
    
    func saveTokens(_ tokens: Tokens){
        if let encoded = try? JSONEncoder().encode(tokens){
            UserDefaults.standard.set(encoded, forKey: "tokens")
        }
    }
    
    func clearTokens(){
        tokens = nil
        UserDefaults.standard.removeObject(forKey: "tokens")
    }
    var isAccessTokenValid: Bool {
        guard let tokens = tokens else { return false }
        return !tokens.accessToken.isEmpty
    }
}
