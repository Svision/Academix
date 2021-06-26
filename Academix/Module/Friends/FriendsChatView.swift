//
//  FriendsChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsChatView: View {
    let chat: Chat
    
    var body: some View {
        Text(chat.sender.name)
    }
}

struct FriendsChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsChatView(chat: .amanda)
    }
}
