//
//  ChatMessage.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: Codable, Identifiable, Equatable {
    var documentId: String? = nil
    let text: String
    let uid: String
    var dateCreated = Date()
    let displayName: String
    
    var id: String {
        documentId ?? UUID().uuidString
    }
    
}

extension ChatMessage {
    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "uid": uid,
            "displayName": displayName,
            "dateCreated": dateCreated
        ]
    }
    
    static func fromSnapshot(snapshot: QueryDocumentSnapshot) -> ChatMessage? {
        let dict = snapshot.data()
        guard let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
              let text = dict["text"] as? String,
              let uid = dict["uid"] as? String,
              let displayName = dict["displayName"] as? String else { return nil }
        
        return ChatMessage(documentId: snapshot.documentID,text: text, uid: uid, dateCreated: dateCreated, displayName: displayName)
    }
}
