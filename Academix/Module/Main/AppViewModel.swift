//
//  AppViewModel.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-03.
//

import Foundation
import Firebase
import Combine

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    let defaults = UserDefaults.standard
    @Published var currUser: User = User(id: "unknown")
    @Published var friendChats: [FriendChat] = []
    @Published var haveNewMessages: Bool = false
    
    init() {
        if isSignedIn {
            if let getUser = defaults.getObject(forKey: defaultsKeys.currUser, castTo: User.self) {
                self.currUser = getUser
                // MARK: add all
                for user in User.all {
                    let chat = FriendChat(myId: currUser.id, friend: user)
                    // MARK: try read saved message
                    if let savedChat = defaults.getObject(forKey: chat.id, castTo: FriendChat.self) {
                        friendChats.append(savedChat)
                    }
                    else {
                        friendChats.append(chat)
                    }
                }
            }
            print("current user: \(self.currUser.id)")
        }
    }
    
    @Published var signedIn = false
    @Published var errorMessage: String?
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
            } else {
                DispatchQueue.main.async {
                    self?.signedIn = true
                    self?.currUser = User(id: email)
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    for user in User.all {
                        let chat = FriendChat(myId: self!.currUser.id, friend: user)
                        // MARK: try read saved message
                        if let savedChat = self?.defaults.getObject(forKey: chat.id, castTo: FriendChat.self) {
                            self!.friendChats.append(savedChat)
                        }
                        else {
                            self!.friendChats.append(chat)
                        }
                    }
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
            } else {
                DispatchQueue.main.async {
                    self?.signedIn = true
                    self?.currUser = User(id: email)
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    for user in User.all {
                        let chat = FriendChat(myId: self!.currUser.id, friend: user)
                        // MARK: try read saved message
                        if let savedChat = self?.defaults.getObject(forKey: chat.id, castTo: FriendChat.self) {
                            self!.friendChats.append(savedChat)
                        }
                        else {
                            self!.friendChats.append(chat)
                        }
                    }
                }
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
        self.currUser = User(id: "unknown")
        self.currUser.saveSelf(forKey: defaultsKeys.currUser)
    }
}
