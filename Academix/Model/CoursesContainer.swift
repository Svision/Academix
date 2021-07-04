//
//  CoursesContainer.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-02.
//

import Foundation

class CoursesContainer : ObservableObject {
    @Published var all = Course.all
    
}
