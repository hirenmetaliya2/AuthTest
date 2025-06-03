//
//  AuthTestApp.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI

@main
struct AuthTestApp: App {
    @StateObject private var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authManager)
        }
    }
}
