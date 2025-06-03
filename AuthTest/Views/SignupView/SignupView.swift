//
//  SignupView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI

struct SignupView: View {

    @State var email: String = ""
    @State var password: String = ""
    @StateObject var signupVM = SignupViewModel()
    @State var errors: String?
    @Environment(\.dismiss) var dismiss
    @State var signupSuccess: Bool = false
    var body: some View {
        
            VStack{
                Text("AuthTest")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .navigationBarBackButtonHidden(true)
            .padding()
            ZStack{
                VStack{
                    Text("Register Here")
                        .font(.headline)
                        .padding(.bottom)
                    TextField("Enter Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                    TextField("Enter Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                    
                    Button{
                        Task{
//                            await registerVM.registerUser(email: email, password: password)
                            signupVM.signup(email: email, password: password)
                        }
                    }label:{
                        Text("REGISTER")
                            .foregroundStyle(.black)
                            .frame(width: 80, height: 20)
                            .padding()
                            .background(Color.blue)
                        
                            .cornerRadius(20)
                        
                    }
                    if errors != nil{
                        Text(errors ?? "")
                    }
                    if signupSuccess{
                        Text("Registered Successfully. Please Login.")
                            .foregroundStyle(.green)
                            
                    }
                    Text("Already have an account?")
                    Button("Login"){
                        dismiss()
                    }
                }
                .padding()
                .background(.blue.opacity(0.2))
                .cornerRadius(20)
            }
            .onReceive(signupVM.$errorMessage){ errorMessage in
                errors = errorMessage
            }
            .onReceive(signupVM.$signupStatus){ signupStatus in
                if signupStatus{
                    signupSuccess = true
                }
            }
        
        }
}

#Preview {
    SignupView()
}
