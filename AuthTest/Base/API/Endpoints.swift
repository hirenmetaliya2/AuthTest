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
}

var provider = MoyaFunctions().createMoyaProvider()

extension Endpoints: TargetType {
    var baseURL: URL {
        return  URL(string:"http://192.168.1.22:8000")!
    }
    
    var path: String {
        switch self{
        case .login:
            return "auth/login"
        case .signup:
            return "auth/register"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .login,
            .signup:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .login(let request),
            .signup(let request):
            return .requestParameters(parameters: request, encoding: JSONEncoding.default)
//        case .signup(let request):
//            return .requestParameters(parameters: request, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
