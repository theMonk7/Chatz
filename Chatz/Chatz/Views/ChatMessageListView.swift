//
//  ChatMessageListView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI

struct ChatMessageListView: View {
    
    let messages: [ChatMessage]
    var body: some View {
        List(messages) { message in
            Text(message.text)
            
        }
    }
}

#Preview {
    ChatMessageListView(messages: [])
}
