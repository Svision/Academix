//
//  CourseItem.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

private var courseId = 0

struct CourseItem: Hashable {
    let name: String
    let id = courseId
    var users: Array<User> = []
    
    static func == (lhs: CourseItem, rhs: CourseItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    init(name: String) {
        self.name = name
        courseId += 1
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
