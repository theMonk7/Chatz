//
//  Model.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import Foundation
import FirebaseAuth

@MainActor
class Model: ObservableObject {
    
    
    func updateDisplayName(for user: User,displayName: String) async throws{
        let request = user.createProfileChangeRequest()
        user.displayName = displayName
        try await request.commitChanges()
    }
}
