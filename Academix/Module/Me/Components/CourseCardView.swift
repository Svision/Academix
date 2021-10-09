//
//  CourseCardView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-02.
//

import SwiftUI

struct CourseCardView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.name)
                .font(.title3)
                .bold()
                .foregroundColor(Color("theme_blue"))
            Text(course.courseDesc)
                .foregroundColor(.black)
        }
        .padding(5)
        .background(Rectangle()
                        .stroke(Color.secondary)
                        .frame(width: 150, height: 150)
                        .background(Color("course_card_bg"))
                        .shadow(color: .primary.opacity(0.3),
                                radius: 3, x: 3, y: 3))
        .frame(width: 160, height: 160)
    }
}

struct CourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        let CSCC10 = Course(university: "UofT",
                            department: "CSC",
                            courseCode: "C10",
                            courseDesc: "Human-Computer Introduction")
        CourseCardView(course: CSCC10)
    }
}
