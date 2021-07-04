//
//  FriendsView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct FriendsView: View {
    @Binding var friendChats: [FriendChat]
    @State var selected: String = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("light_gray")
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    FriendsFilterByCourse(selected: $selected)
                    FriendsChatList(friendChats: $friendChats, selected: $selected)
                }
            }
        }
    }
}

//struct FriendsView_Previews: PreviewProvider {
//    @State static var selected = ""
//    static var previews: some View {
//        FriendsView(selected: selected)
//    }
//}
