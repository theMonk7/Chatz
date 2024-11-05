//
//  GroupDetailView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI
import FirebaseAuth

struct GroupDetailView: View {
    let group: Group
    @State private var chatMessage = ""
    @EnvironmentObject private var model: Model
    
    
    private func sendMessage() async throws {
        guard let currentUser = Auth.auth().currentUser else { return }
        let chatMessage = ChatMessage(text: chatMessage, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        try await model.saveChatMessageToGroup(chat: chatMessage, group: group)
    }
    
    var body: some View {
        VStack {
            ChatMessageListView(messages: model.chatMessages)
            Spacer()
            HStack {
                TextField("Enter message", text: $chatMessage)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    Task {
                        do {
                            try await sendMessage()
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                })
            }
            
        }
        .padding()
        .onAppear {
            model.listenForChatMessage(in: group)
        }
        .onDisappear(perform: {
            model.detachListener()
        })
    }
}

#Preview {
    GroupDetailView(group: Group(subject: "Groceries"))
        .environmentObject(Model())
}
