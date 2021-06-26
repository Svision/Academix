//
//  CourseItem.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct CourseItem: Hashable, Identifiable {
    let name: String
    let id = UUID()
    var users: Array<User> = []
    
    static func == (lhs: CourseItem, rhs: CourseItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    init(name: String) {
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
