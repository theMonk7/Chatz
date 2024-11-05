//
//  AppState.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import Foundation

enum Route {
    case main
    case login
    case signUp
}

class AppState: ObservableObject {
    @Published  var routes: [Route] = []
}
