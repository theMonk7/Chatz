//
//  Model.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


@MainActor
class Model: ObservableObject {
    
    @Published var groups: [Group] = []
    @Published var chatMessages: [ChatMessage] = []
    var fireStoreListener: ListenerRegistration?
    
    func populateGroups() async throws {
        let db = Firestore.firestore()
        do {
            let snapshtop = try await db.collection("groups").getDocuments()
            groups = snapshtop.documents.compactMap { snapshot in
                Group.fromSnapshot(snapshop: snapshot)
            }
        } catch let error {
            throw error
        }
    }
    
    func detachListener() {
        self.fireStoreListener?.remove()
    }
    
    func listenForChatMessage(in group: Group) {
        let db = Firestore.firestore()
        chatMessages.removeAll()
        guard let docId = group.documentId else { return }
        
        self.fireStoreListener = db.collection("groups")
            .document(docId)
            .collection("messages")
            .order(by: "dateCreated",descending: false)
            .addSnapshotListener({ [weak self] snapshot, error in
                guard let snapShot = snapshot else {return}
                snapShot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let chatMessage = ChatMessage.fromSnapshot(snapshot: diff.document)
                        if let chatMessage {
                            let exists = self?.chatMessages.contains(where: { cm in
                                cm.documentId == chatMessage.documentId
                            })
                            
                            if !exists! {
                                self?.chatMessages.append(chatMessage)
                            }
                        }
                        
                    }
                }
            })
    }
    
    func saveChatMessageToGroup(text: String, group: Group, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        guard let groupDocId = group.documentId else { return }
        db.collection("groups")
            .document(groupDocId)
            .collection("messages")
            .addDocument(data: ["chatText": text]) { error in
                completion(error)
            }
        
    }
    
    func updateDisplayName(for user: User,displayName: String) async throws{
        let request = user.createProfileChangeRequest()
        user.displayName = displayName
        try await request.commitChanges()
    }
    
    func saveGroup(group: Group, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var docRef: DocumentReference? = nil
        docRef = db.collection("groups")
            .addDocument(data: group.toDictionary()) {[weak self] error in
                if error != nil {
                    completion(error)
                } else {
                    // add the group to groups array
                    if let docRef {
                        var newGroup = group
                        newGroup.documentId = docRef.documentID
                        self?.groups.append(newGroup)
                    }
                    completion(nil)
                }
            }
    }
    
    func saveChatMessageToGroup(chat: ChatMessage, group: Group) async throws {
        let db = Firestore.firestore()
        guard let groupDocId = group.documentId else { return }
        try await db.collection("groups")
            .document(groupDocId)
            .collection("messages")
            .addDocument(data: chat.toDictionary())
    }
}
