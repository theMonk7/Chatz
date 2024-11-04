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
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func signUp() async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
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
            TextField("Display Name", text: $displayName)
            
            
            HStack {
                
                Button(action: {
                    Task {
                        await signUp()
                    }
                }, label: {
                    Text("Sign Up")
                })
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Login")
                })
                .buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    SignUpView()
}
