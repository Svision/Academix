//
//  MessageRow.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-30.
//

import SwiftUI
import Kingfisher

struct MessageRow: View {
    @EnvironmentObject var viewModel: AppViewModel
    let message: Message
    let isMe: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if isMe { Spacer() } else {
                NavigationLink(destination: FriendDetailView(friend: message.sender)) {
                    Avatar(icon: message.sender.avatar)
                }
            }
            
            TextMessage(isMe: isMe, text: message.text)
            
            if isMe {NavigationLink(destination: FriendDetailView(friend: viewModel.currUser)) {
                Avatar(icon: viewModel.currUser.avatar)
            } } else { Spacer() }
        }
        .padding(.init(top: 8, leading: 12, bottom: 8, trailing: 12))
    }
    
    struct Avatar: View {
        let icon: String
        
        var body: some View {
            if icon.hasPrefix("https") {
                KFImage(URL(string: icon))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(25)
            }
            else {
                Image(icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(25)
            }
        }
    }
    
    struct TextMessage: View {
        let isMe: Bool
        let text: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 0) {
                if !isMe { Arrow(isMe: isMe) }
                
                Text(text)
                    .font(.system(size: 17))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(background)
                    .contextMenu(ContextMenu(menuItems: {
                        Button("Copy", action: {
                            UIPasteboard.general.string = text
                        })
                        Button("Report", action: {
                        })
                    }))
                
                if isMe { Arrow(isMe: isMe) }
            }
        }
        
        private var background: some View {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color("chat_\(isMe ? "me" : "friend")_background"))
        }
    }
    
    struct Arrow: View {
        let isMe: Bool
        
        var body: some View {
            Path { path in
                path.move(to: .init(x: isMe ? 0 : 6, y: 14))
                path.addLine(to: .init(x: isMe ? 0 : 6, y: 26))
                path.addLine(to: .init(x: isMe ? 6 : 0, y: 20))
                path.addLine(to: .init(x: isMe ? 0 : 6, y: 14))
            }
            .fill(Color("chat_\(isMe ? "me" : "friend")_background"))
            .frame(width: 6, height: 30)
        }
    }
}
