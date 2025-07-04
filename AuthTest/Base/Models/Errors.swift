//
//  Errors.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation

enum Errors: String, Error{
    case invalidEmail = "Invalid email"
    case invalidPassword = "Invalid password"
    case invalidToken = "Invalid token"
    case jsonDecodingFailed = "Json decoding failed"
    case jsonEncodingFailed = "Json encoding failed"
    case missingAccessToken = "Missing access token"
    
}
