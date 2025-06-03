//
//  Tokens.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation

struct Tokens: Codable{
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
    }
    
    
}
