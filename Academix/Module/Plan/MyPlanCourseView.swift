//
//  MyPlanCourseView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-11.
//

import SwiftUI

struct MyPlanCourseView: View {
    var course: Course
    
    var body: some View {
        VStack {
            Text("course: \(course.name)")
            Text("Implementing...")
        }
    }
}

struct MyPlanCourseView_Previews: PreviewProvider {
    static var CSC404 = Course(university: "UofT",
                        department: "CSC",
                        courseCode: "404",
                        courseDesc: "Video Game Design",
                        students: [])
    static var previews: some View {
        MyPlanCourseView(course: CSC404)
    }
}
