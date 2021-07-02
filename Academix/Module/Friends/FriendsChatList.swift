//
//  FriendsChatList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatList: View {
    @State private var chats: [FriendChat] = []
    @Binding var selected: String
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(chats) { chat in
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
        .onAppear(perform: load)
    }
    
    func load() {
        guard chats.isEmpty else { return }
        chats = FriendChat.all
        for chat in chats {
            chat.getThisDM()
        }
    }
}

struct FriendsChatList_Previews: PreviewProvider {
    @State static var selected = ""
    static var previews: some View {
        FriendsChatList(selected: $selected)
    }
}
