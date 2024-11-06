//
//  ChatMessageView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI
enum ChatMessageDirection {
    case left
    case right
}
struct ChatMessageView: View {
    
    let chatMessage: ChatMessage
    let direction: ChatMessageDirection
    let color: Color
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(chatMessage.displayName)
                    .opacity(0.8)
                    .font(.caption)
                    
                Text(chatMessage.text)
                Text(chatMessage.dateCreated, format: .dateTime)
                    .font(.caption)
                    .opacity(0.4)
                    .frame(maxWidth: 200,alignment: .trailing)
            }
            .foregroundColor(.white)
            .padding(8)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .listRowSeparator(.hidden)
        .overlay(alignment: direction == .left ? .bottomLeading : .bottomTrailing) {
            Image(systemName: "arrowtriangle.down.fill")
                .font(.title)
                .rotationEffect(.degrees(direction == .left ? 45 : -45))
                .offset(x: direction == .left ? 30 : -30, y : 10)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    ChatMessageView(chatMessage: ChatMessage(text: "111", uid: "223", displayName: "fdfd"), direction: .left, color: .green)
}
