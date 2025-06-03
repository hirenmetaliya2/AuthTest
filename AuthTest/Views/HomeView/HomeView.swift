//
//  HomeView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        Text("No place like 127.0.0.1")
            .navigationBarBackButtonHidden(true)
        Button("Logout"){
            authManager.clearTokens()
        }
    }
}
