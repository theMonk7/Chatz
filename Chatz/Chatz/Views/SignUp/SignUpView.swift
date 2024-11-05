//
//  SignUpView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String  = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    @EnvironmentObject private var model: Model
    @EnvironmentObject private var appState: AppState
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await model.updateDisplayName(for: result.user, displayName: displayName)
            errorMessage = ""
        } catch let error {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("Display Name", text: $displayName)
            
            
            HStack {
                
                Button(action: {
                    Task {
                        await signUp()
                    }
                }, label: {
                    Text("SignUp")
                })
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Spacer()
                
                Button(action: {
                    appState.routes.append(.login)
                }, label: {
                    Text("Login")
                })
                .buttonStyle(.borderless)
            }
            
            Text(errorMessage)
                .foregroundStyle(.red)
        }
        .navigationTitle("SignUp")
    }
}

#Preview {
    SignUpView()
        .environmentObject(Model())
        .environmentObject(AppState())
}
