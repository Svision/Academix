//
//  FriendsView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("light_gray")
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
//                    Spacer()
                    FriendsChatList()
                }
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
