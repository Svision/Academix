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
    @Published var haveNewFriendChatMessages: Bool = false
    @Published var haveNewCourseChatMessages: Bool = false
    
    init() {
        if isSignedIn {
            if let getUser = defaults.getObject(forKey: defaultsKeys.currUser, castTo: User.self) {
                    self.currUser = getUser
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
                    self?.currUser = User.findUser(id: email)
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    self?.setUserInDB()
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
                    self?.currUser = User.findUser(id: email)
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    self?.setUserInDB()
                }
            }
        }
    }
    
    func setUserInDB() {
        let me = self.currUser
        let fcmToken = Messaging.messaging().fcmToken
        let db = Firestore.firestore().collection("Users").document(me.id)
        var coursesId: [Course.ID] = []
        var friendsId: [User.ID] = []
        for course in me.courses {
            coursesId.append(course.id)
        }
        for friend in me.friends {
            friendsId.append(friend.id)
        }
        db.setData([
            "avatar": me.avatar,
            "courses": coursesId,
            "name": me.name,
            "university": me.university,
            "friendsId": friendsId,
            "fcmToken": fcmToken!
        ]) {
            err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            else {
                print("successfully set user")
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        // remove cache upon signedOut
        self.signedIn = false
        self.currUser = User(id: "unknown")
        self.currUser.saveSelf(forKey: defaultsKeys.currUser)
    }
    
    func addNewCourse(_ course: Course) {
        if !self.currUser.courses.contains(course) {
            self.currUser.courses.append(course)
            self.currUser.saveSelf(forKey: defaultsKeys.currUser)
        }
    }
    
    func removeCourse(_ course: Course) {
        if let index = self.currUser.courses.firstIndex(of: course) {
            self.currUser.courses.remove(at: index)
            self.currUser.saveSelf(forKey: defaultsKeys.currUser)
        }
    }
    
    func addNewFriend(_ email: String) -> Bool {
        let friend = fetchUser(email: email)
        if friend == User.unknown {
            return false
        }
        if !self.currUser.friends.contains(friend) {
            self.currUser.friends.append(friend)
            self.currUser.friendChats.append(FriendChat(myId: self.currUser.id, friend: friend))
            self.currUser.saveSelf(forKey: defaultsKeys.currUser)
            return true
        }
        else {
            return false
        }
    }
    
    func removeFriend(_ friend: User) {
        if let index = self.currUser.friends.firstIndex(of: friend) {
            self.currUser.friends.remove(at: index)
            self.currUser.saveSelf(forKey: defaultsKeys.currUser)
        }
        for (index, chat) in self.currUser.friendChats.enumerated() {
            if chat.friend == friend {
                self.currUser.friendChats.remove(at: index)
                break
            }
        }
    }
    
    func fetchUser(email: String) -> User {
        // tmp
        return User.findUser(id: email)
    }
}
