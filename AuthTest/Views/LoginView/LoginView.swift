//
//  LoginView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//



import SwiftUI

struct LoginView: View {
    @Binding var path: NavigationPath
    @StateObject var loginVM = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager : AuthManager
    
    
    var body: some View {
        title
            ZStack{
                VStack{
                    inputFields
                    loginButton
                    if let error = loginVM.errorMessage{
                        Text(error)
                    }
                    Text("Don't have an account?")
                    Button("Signup"){
                        path.append(Routes.signup)
                    }
                }
                .padding()
                .background(.blue.opacity(0.2))
                .cornerRadius(20)
            }
    }
    
    private var title: some View {
        VStack{
            Text("AuthTest")
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
    }
    private var inputFields: some View {
        VStack{
            Text("Login Here")
                .font(.headline)
                .padding(.bottom)
            TextField("Enter Email", text: $loginVM.email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .textInputAutocapitalization(.never)
            SecureField("Enter Password", text: $loginVM.password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .textInputAutocapitalization(.never)
        }
    }
    private var loginButton: some View {
        Button{
            Task{
                loginVM.login(authManager: authManager)
            }
            
        }label:{
            Text("LOGIN")
                .foregroundStyle(.black)
                .frame(width: 80, height: 20)
                .padding()
                .background(Color.blue)
            
                .cornerRadius(20)
            
        }
    }
}

#Preview {
    LoginView(path: .constant(NavigationPath()))
        .environmentObject(AuthManager())
}

