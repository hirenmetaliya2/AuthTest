//
//  MoyaFunctions.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import Foundation
import Moya

struct MoyaFunctions{
    func createMoyaProvider() -> MoyaProvider<Endpoints> {
        var config = NetworkLoggerPlugin.Configuration()
            config.logOptions = [NetworkLoggerPlugin.Configuration.LogOptions.successResponseBody, NetworkLoggerPlugin.Configuration.LogOptions.requestMethod, NetworkLoggerPlugin.Configuration.LogOptions.errorResponseBody, NetworkLoggerPlugin.Configuration.LogOptions.requestBody]

        config.output = logNetwork
        let provider = MoyaProvider<Endpoints>(plugins: [NetworkLoggerPlugin(configuration: config)])
        
        return provider
    }
    
    public func logNetwork(target: TargetType, items: [String]) {
        print("\(target.method) \(target.baseURL)\(target.path)")
        items.forEach{print($0)}
    }
}
