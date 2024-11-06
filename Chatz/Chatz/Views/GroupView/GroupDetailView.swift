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
    @EnvironmentObject private var appState: AppState
    
    private func sendMessage() async throws {
        guard let currentUser = Auth.auth().currentUser else { return }
        let chatMessage = ChatMessage(text: chatMessage, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        try await model.saveChatMessageToGroup(chat: chatMessage, group: group)
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ChatMessageListView(messages: model.chatMessages)
                    .onChange(of: model.chatMessages) { oldValue, newValue in
                        let lastMessage = model.chatMessages[model.chatMessages.endIndex - 1]
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
            }
            Spacer()
            HStack {
                TextField("Enter message", text: $chatMessage)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    Task {
                        do {
                            appState.loadingState = .loading("Messages Loading")
                            try await sendMessage()
                            chatMessage = ""
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        appState.loadingState = .idle
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
        .environmentObject(AppState())
}
