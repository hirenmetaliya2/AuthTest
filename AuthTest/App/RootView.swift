//
//  RootView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 03/06/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var path = NavigationPath()
    var body: some View {
        if authManager.isAccessTokenValid {
            HomeView()
        } else{
            NavigationStack(path: $path){
                LoginView(path: $path)
                    .navigationDestination(for: Routes.self) { route in
                        switch route{
                        case .signup:
                            SignupView()
                        }
                    }
            }
        }
    }
}
