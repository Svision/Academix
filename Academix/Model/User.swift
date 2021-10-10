//
//  User.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation
import Firebase
import Combine

class User: Identifiable, ObservableObject, Codable, Equatable  {
    // basic info
    @Published var name: String = ""
    @Published var avatar: String = ""
    @Published var university: String = ""
    @Published var contributions: Int = 0
    @Published var receivedLikes: Int = 0
    @Published var interests = [String: Int]()
    let id: String
    @Published var courses: Array<Course> = []
    
    // setting
    var major: String = ""
    var url: String = ""
    
    // relation
    @Published var friends: [User] = []
    @Published var friendChats: [FriendChat] = []
    
    init(name: String, avatar: String, university: String, email: String) {
        self.name = name
        self.avatar = avatar
        self.university = university
        self.id = email
    }
    
    init(id: String) {
        self.id = id
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func getAvatar() -> String {
        return self.avatar
    }
    
    func getCoursesString() -> String {
        if courses.count == 0 { return "" }
        var coursesString: String = ""
        for course in courses {
            let courseIdArr = course.id.components(separatedBy: ".")
            coursesString += "\(courseIdArr[1])\(courseIdArr[2]), "
        }
        return coursesString.subString(to: coursesString.count - 2)
    }
    
    func addFriend(_ friend: User) {
        for currfriend in self.friends {
            if currfriend.id == friend.id {
                return
            }
        }
        self.friends.append(friend)
    }
    
    func addCourse(_ course: Course) {
        for currCourse in self.courses {
            if currCourse.id == course.id {
                return
            }
        }
        self.courses.append(course)
        self.courses.sort { (course1, course2) -> Bool in
            return (course1.courseCode < course2.courseCode)
        }
    }
    
    func updateFromDB() {
        let users = Firestore.firestore().collection("Users")
        users.document(self.id).getDocument { doc, err in
            if let doc = doc, doc.exists {
                self.avatar = doc.get("avatar") as! String
                self.name = doc.get("name") as! String
                self.university = doc.get("university") as! String
            }
        }
    }
    
    func getFriend(by id: String) -> User {
        for friend in friends {
            if friend.id == id {
                return friend
            }
        }
        return .unknown
    }
}

extension User {
    static let unknown = User(
        name: "unknown",
        avatar: "data_avatar0",
        university: "undefined",
        email: "unknown@academix.com"
    )
}
