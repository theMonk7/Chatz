//
//  Group.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import Foundation
import FirebaseFirestore

struct Group: Codable, Identifiable {
    var documentId: String? = nil
    let subject: String
    
    var id: String {
        documentId ?? UUID().uuidString
    }
}

extension Group {
    func toDictionary() -> [String: Any] {
        return ["subject": subject]
    }
    
    static func fromSnapshot(snapshop: QueryDocumentSnapshot) -> Group? {
        let dict = snapshop.data()
        guard let subject = dict["subject"] as? String  else { return nil }
        return Group(documentId: snapshop.documentID ,subject: subject)
    }
}
