//
//  FriendsChatRow.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatRow: View {
    @ObservedObject var chat: FriendChat
    
    var body: some View {
        HStack(spacing: 12) {
            Image(chat.friend.avatar)
                .renderingMode(.original)
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(25)
                .overlay(NotificationNumLabel(number: $chat.unreadMessages))
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    HStack {
                        let senderExtention = chat.friend.courses.count == 0 ? Text("") : Text(" - \(chat.friend.getCoursesString())").foregroundColor(.gray)
                        
                        Text("\(chat.friend.name)\(senderExtention)")
                            .lineLimit(1)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    lastChatTimestamp()
                }
                
                Text(chat.lastMessage().text)
                    .lineLimit(1)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
    
    func lastChatTimestamp() -> Text? {
        let lastTime = chat.lastMessage().timestamp
        if lastTime == Date(timeIntervalSince1970: 0) {
            return nil
        }
        else {
            return Text(lastTime.formatString)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
        }
    }
}
    
//struct FriendsChatRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsChatRow(chat: .amanda)
//    }
//}
