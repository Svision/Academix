//
//  MessageList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI

struct MessageList: View {
    @State private var messages: [Message] = []
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 0) {
                    ForEach(messages) { message in
                        if let createdAt = message.timestamp {
                            Time(date: createdAt)
                        }
                        
                        MessageRow(
                            message: message,
                            isMe: message.sender == User.me.id
                        )
                        .id(message.id)
                    }
                }
                .background(Color("light_gray"))
                .onChange(of: messages) { messages in
                    if let lastId = messages.last?.id {
                        proxy.scrollTo(lastId) // scoll to last message onChange
                    }
                }
            }
        }
        .onAppear(perform: load)
    }
    
    func load() {
        guard messages.isEmpty else { return }
        messages = Message.all
    }
    
    struct Time: View {
        let date: Date
        
        var body: some View {
            Text(date.formatString)
                .foregroundColor(Color("chat_time"))
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageList()
    }
}
