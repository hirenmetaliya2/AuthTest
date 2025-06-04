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
    @StateObject private var homeVM = HomeViewModel()
    var body: some View {
        Text("No place like 127.0.0.1")
            .navigationBarBackButtonHidden(true)
        if let error = homeVM.errorMessage{
            Text(error)
                .padding()
        }
        
        if let response = homeVM.userData{
            VStack{
                Text("id: \(response.id)")
                Text("Email: \(response.email)")
            }
        }
        
        Button("Logout"){
            authManager.clearTokens()
        }
        .onAppear{
            homeVM.fetchUserData()
        }
    }
}

#Preview {
    HomeView()
}
