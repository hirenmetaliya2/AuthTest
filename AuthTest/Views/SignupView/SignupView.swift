//
//  SignupView.swift
//  AuthTest
//
//  Created by Hiren Metaliya on 02/06/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var signupVM = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
            ZStack{
                VStack{
                    title
                    inputFields
                    signupButton
                    signupStatus
                    Text("Already have an account?")
                    Button("Login"){
                        dismiss()
                    }
                }
                .padding()
                .background(.blue.opacity(0.2))
                .cornerRadius(20)
            }
        }
    
    private var inputFields: some View{
        VStack{
            TextField("Enter Email", text: $signupVM.email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
            TextField("Enter Password", text: $signupVM.password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
        }
    }
    
    private var title: some View{
        VStack{
            Text("AuthTest")
                .font(.title)
                .fontWeight(.bold)
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
    
    private var signupStatus: some View{
        VStack{
            if let error = signupVM.errorMessage{
                Text(error)
            }
            if signupVM.signupStatus{
                Text("Registered Successfully. Please Login.")
                    .foregroundStyle(.green)
            }
        }
    }
    
    private var signupButton: some View{
        Button{
            Task{
                signupVM.signup()
            }
        }label:{
            Text("Register")
                .foregroundStyle(.black)
                .frame(width: 80, height: 20)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
}

#Preview {
    SignupView()
}
