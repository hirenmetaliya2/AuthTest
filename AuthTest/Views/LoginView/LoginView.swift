//
//  LoginView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//



import SwiftUI

struct LoginView: View {
    @Binding var path: NavigationPath
    @State var email: String = ""
    @State var password: String = ""
    @StateObject var registerVM = SignupViewModel()
    @StateObject var loginVM = LoginViewModel()
    @State var errors: String?
    @State private var goToHome: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager : AuthManager
    
    
    var body: some View {
            VStack{
                Text("AuthTest")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            .padding()
            ZStack{
                VStack{
                    Text("Login Here")
                        .font(.headline)
                        .padding(.bottom)
                    TextField("Enter Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .textInputAutocapitalization(.never)
                    SecureField("Enter Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .textInputAutocapitalization(.never)
                    
                    HStack {
                        Button{
                            Task{
                                loginVM.login(email: email, password: password)
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
                    if errors != nil{
                        Text(errors ?? "")
                    }
                    Text("Don't have an account?")
                    Button("Signup"){
                        path.append(Routes.signup)
                    }
                }
                .padding()
                .background(.blue.opacity(0.2))
                .cornerRadius(20)
                .onReceive(loginVM.$errorMessage){ errorMessage in
                    errors = errorMessage
                }
                .onReceive(loginVM.$isLogin){ isLogin in
                    if isLogin{
                        if let tokens = loginVM.tokens{
                            authManager.tokens = tokens
                            authManager.saveTokens(tokens)
                        }
                        
                    }else{
                        errors = loginVM.errorMessage
                    }
                }
                
            }
    }
}

#Preview {
    LoginView(path: .constant(NavigationPath()))
        .environmentObject(AuthManager())
}

