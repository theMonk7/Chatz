//
//  LoginView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String  = ""
    @State private var errorMessage: String = ""
    @EnvironmentObject private var appState: AppState
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
        // TODO: -
        // if authenticated, go to the main screen
            appState.routes.append(.main)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            
            
            HStack {
                
                Button(action: {
                    Task {
                        await login()
                    }
                }, label: {
                    Text("Login")
                })
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Spacer()
                
                Button(action: {
                    appState.routes.append(.signUp)
                }, label: {
                    Text("SignUp")
                })
                .buttonStyle(.borderless)
            }
            
            Text(errorMessage)
                .foregroundStyle(.red)
        }
        .navigationTitle("Login")
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
