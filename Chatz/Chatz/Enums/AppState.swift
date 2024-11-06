//
//  AppState.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import Foundation
import UIKit

enum Route {
    case main
    case login
    case signUp
}

class AppState: ObservableObject {
    @Published  var routes: [Route] = []
}


extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
        case .camera:
            return 1
        case .photoLibrary:
            return 2
        default:
            return 3
        }
    }
    
    
}
