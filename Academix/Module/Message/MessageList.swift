//
//  MessageList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI

struct MessageList: View {
    @Binding var messages: Array<Message>
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 0) {
                    ForEach(messages) { message in
                        VStack(spacing: 0){
                            if firstTime(message: message) {
                                Time(date: message.timestamp)
                            }
                            
                            MessageRow(
                                message: message,
                                isMe: message.senderId == viewModel.currUser.id
                            )
                        }
                        .id(message.id)
                    }
                }
                .background(Color("light_gray"))
                .onAppear {
                    proxy.scrollTo(messages.last?.id, anchor: .bottom)
                }
                .onChange(of: messages) { messages in
                    if let lastId = messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastId, anchor: .bottom)// scoll to last message onChange
                        }
                    }
                }
            }
        }
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
    
    func firstTime(message: Message) -> Bool {
        for msg in messages {
            if msg.timestamp.formatString == message.timestamp.formatString && msg.timestamp <= message.timestamp && msg.id != message.id {
                return false
            }
        }
        return true
    }
    
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageList()
//    }
//}
