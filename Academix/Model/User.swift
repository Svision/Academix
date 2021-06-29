//
//  User.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct User: Identifiable, Codable {
    // basic info
    var name: String
    var avatar: String
    var university: String
    let id: String // email == id
    var courses: Array<CourseItem>
    
    // setting
    var major: String = ""
    var url: String = ""
    
    // relation
    var friends: Array<User> = []
    
    init(name: String, avatar: String, university: String, email: String, courses: Array<CourseItem> = []) {
        self.name = name
        self.avatar = avatar
        self.university = university
        self.id = email
        self.courses = courses
    }
    
    func getCoursesString() -> String {
        if courses.count == 0 { return "" }
        var coursesString: String = ""
        for course in courses {
            coursesString += "\(course.name), "
        }
        return coursesString.subString(to: coursesString.count - 2)
    }
}

extension User {
    static let me = User(
        name: "Changhao",
        avatar: "data_avatar1",
        university: "UofT",
        email: "changhao.song@mail.utoronto.ca",
        courses: CourseItem.all
    )
    
    static let amanda = User(
        name: "Sweety🍬",
        avatar: "data_avatar2",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.csc373, .sta301, .mat301]
    )
    
    static let sky = User(
        name: "sky",
        avatar: "data_avatar3",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.csc369, .csc373]
    )
    
    static let yuhong = User(
        name: "Yuhong",
        avatar: "data_avatar4",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.cscc10]
    )
    
    static let meixuan = User(
        name: "Meixuan",
        avatar: "data_avatar5",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.csc369, .cscc10]
    )
    
    static let xiaoning = User(
        name: "Xiaoning",
        avatar: "data_avatar6",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.cscc10]
    )
    
    static let yitong = User(
        name: "Yitong",
        avatar: "data_avatar7",
        university: "UofT",
        email: "@mail.utoronto.ca",
        courses: [.cscc10]
    )
    
    static let owen = User(
        name: "Owen",
        avatar: "data_avatar8",
        university: "McMaster",
        email: "@mcmaster.ca"
    )
    

    static let leon = User(
        name: "Leon",
        avatar: "data_avatar10",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
    
    static let bill = User(
        name: "Bill",
        avatar: "data_avatar9",
        university: "University of Melbourne",
        email: "@melbourne.au"
    )
}
