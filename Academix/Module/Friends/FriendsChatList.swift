//
//  FriendsChatList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatList: View {
    @Binding var chats: [FriendChat]
    @Binding var selected: String
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(chats.sorted(by: {$0.lastMessage().timestamp > $1.lastMessage().timestamp})) { chat in
                    NavigationLink(destination: FriendsChatView(chat: chat).onAppear { chat.unreadMessages = 0 }) {
                        VStack(spacing: 0) {
                            FriendsChatRow(chat: chat)
                            Separator()
                        }
                        .isHidden(!(selected == "" || chat.friend.getCoursesString().contains(selected)), remove: true)
                    }
                }
            }
            .background(Color("cell"))
        }
        .onAppear { sort() }
    }
    
    func sort() {
        guard !self.chats.isEmpty else {
            print("no friends chat")
            return
        }
        self.chats.sort(by: { $0.lastMessage().timestamp > $1.lastMessage().timestamp })
    }
}

//struct FriendsChatList_Previews: PreviewProvider {
//    @State static var selected = ""
//    static var previews: some View {
//        FriendsChatList(selected: $selected)
//    }
//}
