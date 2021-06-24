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
    
    init(name: String) {
        self.name = name
        courseId += 1
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
