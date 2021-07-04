//
//  FriendsContainer.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-02.
//

import Foundation

class FriendsContainer : ObservableObject, Codable {
    @Published var allChats: [FriendChat] = []
    @Published var allFriends: [User] = []
    @Published var haveNewMessage = false
}
