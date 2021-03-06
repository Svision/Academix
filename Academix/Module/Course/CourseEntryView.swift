//
//  CourseEntryView.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-02.
//

import SwiftUI

struct CourseEntryView: View {
    @ObservedObject var course: Course
    
    var body: some View {
        Text(course.name)
            .foregroundColor(.primary)
            .font(.title2)
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color("inverse_primary"))
                            .frame(width: 150, height: 60))
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary)
                        .frame(width: 150, height: 60))
            .overlay(NotificationNumLabel(number: $course.unreadMessages, forCourse: true))
    }
}
