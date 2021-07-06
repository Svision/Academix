//
//  FriendsChatList.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI
import CoreHaptics

struct FriendsChatList: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var friendChats: [FriendChat]
    @Binding var selected: String
    @Binding var engine: CHHapticEngine?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(friendChats, id: \.id) { chat in
                    NavigationLink(destination: FriendsChatView(chat: chat).onAppear {
                        chat.readed()
                        viewModel.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    }) {
                        VStack(spacing: 0) {
                            FriendsChatRow(chat: chat, engine: $engine)
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
