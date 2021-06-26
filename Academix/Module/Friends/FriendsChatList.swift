//
//  FriendsChatList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatList: View {
    @State private var chats: [Chat] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(chats) { chat in
                    NavigationLink(destination: FriendsChatView(chat: chat)) {
                        FriendsChatRow(chat: chat)
                    }
                    Separator()
                }
            }
            .background(Color("cell"))
        }
        .onAppear(perform: load)
    }
    
    func load() {
        guard chats.isEmpty else { return }
        chats = Chat.all
    }
}

struct FriendsChatList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsChatList()
    }
}
