//
//  AppViewModel.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-03.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseStorageSwift
import Combine
import SwiftUI

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    let defaults = UserDefaults.standard
    @Published var currUser: User = User(id: "unknown")
    @Published var haveNewFriendChatMessages: Bool = false
    @Published var haveNewCourseChatMessages: Bool = false
    var cancellable : AnyCancellable? = nil
    
    init() {
        if isSignedIn {
            if let getUser = defaults.getObject(forKey: defaultsKeys.currUser, castTo: User.self) {
                self.currUser = getUser
                self.cancellable = self.currUser.objectWillChange.sink { [weak self] (_) in
                    self?.objectWillChange.send()
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
                AppViewModel.fetchUser(email: email) { user in
                    if user != nil {
                        self?.currUser = user!
                    }
                    else {
                        self?.currUser = User(id: email)
                        self?.setUserDB()
                    }
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    self?.signedIn = true
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
            } else {
                self?.currUser = User(id: email)
                DispatchQueue.main.async {
                    self?.setUserDB()
                    self?.currUser.saveSelf(forKey: defaultsKeys.currUser)
                }
                self?.signedIn = true
            }
        }
    }
    
    func setUserDB() {
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
            "coursesId": coursesId,
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
            setUserDB()
        }
    }
    
    func addNewFriend(_ email: String) {
        AppViewModel.fetchUser(email: email) { friend in
            if friend != nil {
                if friend!.id == User.unknown.id {
                    return
                }
                if !self.currUser.friends.contains(friend!) {
                    self.currUser.friends.append(friend!)
                    self.currUser.friendChats.append(FriendChat(myId: self.currUser.id, friend: friend!))
                    self.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    self.setUserDB()
                }
            }
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
        setUserDB()
    }
    
    static func fetchUser(email: String, completion: @escaping (User?) -> ()){
        let users = Firestore.firestore().collection("Users")
        users.document(email).getDocument { doc, err in
            if let doc = doc, doc.exists {
                let avatar = doc.get("avatar") as! String
                let coursesId = doc.get("coursesId") as! Array<String>
                let friendsId = doc.get("friendsId") as! Array<String>
                let name = doc.get("name") as! String
                let university = doc.get("university") as! String
                
                let user = User(name: name, avatar: avatar, university: university, email: email)
                for courseId in coursesId {
                    self.fetchCourse(courseId: courseId) { course in
                        if course != nil {
                            user.courses.append(course!)
                        }
                    }
                }
                
                for friendId in friendsId {
                    users.document(friendId).getDocument { doc, err in
                        if let doc = doc, doc.exists {
                            let friendAvatar = doc.get("avatar") as! String
                            let friendCoursesId = doc.get("coursesId") as! Array<String>
                            let friendName = doc.get("name") as! String
                            let friendUniversity = doc.get("university") as! String
                            
                            let friend = User(name: friendName, avatar: friendAvatar, university: friendUniversity, email: friendId)
                            for courseId in friendCoursesId {
                                self.fetchCourse(courseId: courseId) { course in
                                    if course != nil { friend.courses.append(course!) }
                                }
                            }
                            
                            user.addFriend(friend)
                            user.friendChats.append(FriendChat(myId: email, friend: friend))
                        }
                    }
                }
                completion(user)
            }
            else {
                print("No user")
                completion(nil)
            }
        }
    }
    
    static func fetchCourse(courseId: String, completion: @escaping (Course?) -> ()) {
        let courseInfo = courseId.components(separatedBy: ".")
        let university = courseInfo[0]
        let department = courseInfo[1]
        let courseCode = courseInfo[2]
        let db = Firestore.firestore().collection("Courses").document(courseId)
        db.getDocument { doc, err in
            if let doc = doc, doc.exists {
                let courseDesc = doc.get("courseDesc") as! String
                let students = doc.get("students") as! Array<String>
                let course = Course(university: university,
                                    department: department,
                                    courseCode: courseCode,
                                    courseDesc: courseDesc,
                                    students: students)
                completion(course)
            }
            else {
                // no course in db
                completion(nil)
            }
        }
    }
    
    func setCourseDB(course: Course) {
        let courses = Firestore.firestore().collection("Courses")
        courses.document(course.id).setData([
            "university": course.university,
            "students": course.students,
            "courseDesc": course.courseDesc
        ]) {
            err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            else {
                print("successfully set course")
            }
        }
    }
    
    func uploadAvatar(image: UIImage, completion: @escaping (String) -> ()) {
        guard let imageData = image.pngData() else {
            return
        }
        let storage = Storage.storage()
        storage.reference().child("Users/\(self.currUser.id)/avatar.png").putData(imageData, metadata: nil) { _, err in
            guard err == nil else {
                print("Failed to upload")
                return
            }
            storage.reference().child("Users/\(self.currUser.id)/avatar.png").downloadURL { url, err in
                guard let url = url, err == nil else {
                    return
                }
                let avatar = url.absoluteString
                self.currUser.avatar = avatar
                self.currUser.saveSelf(forKey: defaultsKeys.currUser)
                self.setUserDB()
                completion(avatar)
            }
        }
    }
}
