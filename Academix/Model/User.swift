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
    var name: String = ""
    var avatar: String = ""
    var university: String = ""
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
    static let all: Array<User> = [
        .changhao,
        .amanda,
        .wayne,
        .liuchang,
        .sky,
        .leon,
        .xiaoning,
        .yuhong,
        .meixuan,
        .yitong,
        .owen,
        .bill,
        .ruizi
    ]
    
    static func findUser(id: String) -> User {
        for user in User.all {
            if user.id == id {
                return user
            }
        }
        return .unknown
    }
    
    static let unknown = User(
        name: "unknown",
        avatar: "data_avatar0",
        university: "undefined",
        email: "unknown@academix.com"
    )
    
    static let changhao = User(
        name: "Changhao",
        avatar: "data_avatar1",
        university: "UofT",
        email: "changhao@academix.com"
    )
    
    static let amanda = User(
        name: "sch的Sweety🍬",
        avatar: "data_avatar2",
        university: "UofT",
        email: "wenqing@academix.com"
    )
    
    static let sky = User(
        name: "sky",
        avatar: "data_avatar3",
        university: "UofT",
        email: "sky@academix.com"
    )
    
    static let yuhong = User(
        name: "Yuhong",
        avatar: "data_avatar4",
        university: "UofT",
        email: "yuhong@academix.com"
    )
    
    static let meixuan = User(
        name: "Meixuan",
        avatar: "data_avatar5",
        university: "UofT",
        email: "meixuan@academix.com"
    )
    
    static let xiaoning = User(
        name: "Xiaoning",
        avatar: "data_avatar6",
        university: "UofT",
        email: "xiaoning@academix.com"
    )
    
    static let yitong = User(
        name: "Yitong",
        avatar: "data_avatar7",
        university: "UofT",
        email: "yitong@academix.com"
    )
    
    static let owen = User(
        name: "Owen",
        avatar: "data_avatar8",
        university: "McMaster",
        email: "owen@academix.com"
    )
    
    
    static let leon = User(
        name: "Leon",
        avatar: "data_avatar10",
        university: "UofT",
        email: "leon@academix.com"
    )
    
    static let bill = User(
        name: "Bill",
        avatar: "data_avatar9",
        university: "University of Melbourne",
        email: "bill@academix.com"
    )
    
    static let ruizi = User(
        name: "Ruizi",
        avatar: "data_avatar11",
        university: "University of Toronto",
        email: "ruizi@academix.com"
    )
    
    static let wayne = User(
        name: "Wayne",
        avatar: "data_avatar12",
        university: "McMaster",
        email: "wayne@academix.com"
    )
    
    static let liuchang = User(
        name: "Liuchang",
        avatar: "data_avatar13",
        university: "McMaster",
        email: "liuchang@academix.com"
    )
}
