//
//  MyPlanView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-11.
//

import SwiftUI

struct MyPlanView: View {
    @Binding var courses: [Course]
    let layout = [GridItem(.adaptive(minimum: 140))]

    var body: some View {
        GeometryReader { proxy in
//            TabView {
                LazyVGrid(columns: layout) {
                    ForEach(courses, id: \.id) { course in
                        NavigationLink(destination: MyPlanCourseView(course: course)) {
                            Text(course.name)
                                .foregroundColor(.primary)
                                .font(.title2)
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("inverse_primary"))
                                                .frame(width: 120, height: 40))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary)
                                            .frame(width: 120, height: 40))
                        }
                        .padding()
                    }
                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear(perform: sortCourses)
        }

    }
    
    func sortCourses() {
        courses.sort { (course1, course2) -> Bool in
            return (course1.courseCode < course2.courseCode)
        }
    }
}
