//
//  ChatzApp.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
@main
struct ChatzApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    @StateObject private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                ZStack {
                    if Auth.auth().currentUser != nil {
                        MainView()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .main:
                        MainView()
                    case .signUp:
                        SignUpView()
                    }
                }
            }
            .overlay(alignment: .top, content: {
                switch appState.loadingState {
                case .idle:
                    EmptyView()
                case .loading(let message):
                    LoaderView(message: message)
                    
                }
            })
            .environmentObject(appState)
            .environmentObject(model)
            
            
        }
    }
}
