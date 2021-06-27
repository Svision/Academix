//
//  FriendsChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatView: View {
    let chat: Chat
    @State private var isMoreInfoViewActive = false
    
    var moreInfoView : some View {
        NavigationLink(destination: FriendsMoreInfoView(friend: chat.sender), isActive: $isMoreInfoViewActive) {
            EmptyView()
        }
    }
    
    var btnMore : some View { Button(action: { isMoreInfoViewActive = true }) {
            Image(systemName: "ellipsis") // more button
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Separator(color: Color("navigation_separator"))
                Spacer()
                Text(chat.desc)
                Spacer()
                ChatSendBar(proxy: proxy)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .background(moreInfoView)
        .navigationBarTitle(chat.sender.name, displayMode: .inline)
        .navigationBarItems(trailing: btnMore)
    }
}

struct FriendsChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsChatView(chat: .amanda)
    }
}
