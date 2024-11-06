//
//  ChatMessageListView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI
import FirebaseAuth

struct ChatMessageListView: View {
    
    
    private func isChatMessageFromCurrentUser(_ chatMessage: ChatMessage) -> Bool {
        guard let currentUser = Auth.auth().currentUser else { return false }
        return currentUser.uid == chatMessage.uid
    }
    
    let messages: [ChatMessage]
    var body: some View {
        ScrollView {
            ForEach(messages) { message in
                VStack {
                    if isChatMessageFromCurrentUser(message) {
                        HStack {
                            Spacer()
                            ChatMessageView(chatMessage: message, direction: .right, color: .blue)
                        }
                    } else {
                        HStack {
                            
                            ChatMessageView(chatMessage: message, direction: .left, color: .gray)
                            Spacer()
                        }
                    }
                    
                    Spacer().frame(height: 20)
                        .id(message.id)
                }
                .listRowSeparator(.hidden)
                
            }
        }
        .padding([.bottom])
    }
}

#Preview {
    ChatMessageListView(messages: [])
}
