//
//  MainView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            appState.routes.removeAll()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            Text("Main View")
            Button {
                Task {
                    signOut()
                }
            } label: {
                Text("Logout")
            }
        }
        .navigationTitle("HOME")

    }
}

#Preview {
    MainView()
}
