//
//  FriendsChatList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatList: View {
    @Binding var friendChats: [FriendChat]
    @Binding var selected: String
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(friendChats, id: \.id) { chat in
                    NavigationLink(destination: FriendsChatView(chat: chat).onAppear {
                        chat.unreadMessages = 0
                        chat.saveSelf(forKey: chat.id)
                    }) {
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
        guard !friendChats.isEmpty else {
            print("no friends chat")
            return
        }
        friendChats.sort(by: { $0.lastMessage().timestamp > $1.lastMessage().timestamp })
    }
}

//struct FriendsChatList_Previews: PreviewProvider {
//    @State static var selected = ""
//    static var previews: some View {
//        FriendsChatList(selected: $selected)
//    }
//}
