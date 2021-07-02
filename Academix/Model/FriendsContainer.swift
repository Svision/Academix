//
//  FriendsContainer.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-02.
//

import Foundation

class FriendsContainer : ObservableObject {
    @Published var all: [FriendChat] = FriendChat.all
    @Published var haveNewMessage = false
}
