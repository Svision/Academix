//
//  CourseItem.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct CourseItem: Hashable, Identifiable {
    let name: String
    let university: String
    let department: String
    let courseCode: String
    let courseDesc: String
    var id = UUID()
    var users: Array<User> = []
    
    static func == (lhs: CourseItem, rhs: CourseItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    init(university: String, department: String, courseCode: String) {
        self.name = department + courseCode
        self.university = university
        self.department = department
        self.courseCode = courseCode
        self.courseDesc = ""
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension CourseItem {
    static let all: [CourseItem] = [cscc10, csc369, csc373, sta301, mat301]
    
    static let cscc10 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "C10"
    )
    
    static let csc369 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "369"
    )
    
    static let csc373 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "373"
    )
    
    static let sta301 = CourseItem(
        university: "UofT",
        department: "STA",
        courseCode: "301"
    )
    
    static let mat301 = CourseItem(
        university: "UofT",
        department: "MAT",
        courseCode: "301"
    )
}
