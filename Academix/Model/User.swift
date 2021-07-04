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
    var courses: Array<Course> = []
    
    // setting
    var major: String = ""
    var url: String = ""
    
    // relation
    var friends: [User] = []
    
    init(name: String, avatar: String, university: String, email: String, courses: Array<Course> = []) {
        self.name = name
        self.avatar = avatar
        self.university = university
        self.id = email
        self.courses = courses
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
    
//    static func getById(id: String, completion: @escaping (User) -> Void) {
//        let db = Firestore.firestore()
//
//        db.collection("Users").getDocuments { snap, err in
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//            if (snap?.documents.isEmpty)! {
//                return
//            }
//            for user in snap!.documents {
//                if id == user.documentID {
//                    let name = user.get("name") as! String
//                    let university = user.get("university") as! String
//                    let avatar = user.get("avatar") as! String
//                    let courses = user.get("courses") as! Array<String>
//                    completion(User(name: name, avatar: avatar, university: university, email: id, courses: courses))
//                }
//                else {
//                    return
//                }
//            }
//        }
//    }
}

extension User {
    static let all: Array<User> = [
        .changhao,
        .amanda,
        .sky,
        .yuhong,
        .meixuan,
        .xiaoning,
        .yitong,
        .owen,
        .leon,
        .bill,
        .ruizi
    ]
    
    static func findUser(id: String) -> User {
        for user in User.all {
            if user.id == id {
                return user
            }
        }
        return .guest
    }
    
    static let guest = User(
        name: "Guest",
        avatar: "data_avatar0",
        university: "undefined",
        email: "guest@academix.com",
        courses: []
    )
    
    static let changhao = User(
        name: "Changhao",
        avatar: "data_avatar1",
        university: "UofT",
        email: "changhao@academix.com",
        courses: [Course.cscc10, Course.csc373, Course.csc369]
    )
    
    static let amanda = User(
        name: "Sweety🍬",
        avatar: "data_avatar2",
        university: "UofT",
        email: "wenqing@academix.com",
        courses: [Course.csc373, Course.sta301, Course.mat301]
    )
    
    static let sky = User(
        name: "sky",
        avatar: "data_avatar3",
        university: "UofT",
        email: "sky@academix.com",
        courses: [Course.csc369, Course.csc373]
    )
    
    static let yuhong = User(
        name: "Yuhong",
        avatar: "data_avatar4",
        university: "UofT",
        email: "yuhong@academix.com",
        courses: [Course.cscc10]
    )
    
    static let meixuan = User(
        name: "Meixuan",
        avatar: "data_avatar5",
        university: "UofT",
        email: "meixuan@academix.com",
        courses: [Course.csc369, Course.cscc10]
    )
    
    static let xiaoning = User(
        name: "Xiaoning",
        avatar: "data_avatar6",
        university: "UofT",
        email: "xiaoning@academix.com",
        courses: [Course.cscc10]
    )
    
    static let yitong = User(
        name: "Yitong",
        avatar: "data_avatar7",
        university: "UofT",
        email: "yitong@academix.com",
        courses: [Course.cscc10]
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
}
