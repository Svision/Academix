//
//  HomeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

var courses: Array<CourseItem> = [CourseItem(name: "CSCC10"),
                                  CourseItem(name: "CSC369"),
                                  CourseItem(name: "CSC373"),
                                  CourseItem(name: "STA301"),
                                  CourseItem(name: "MAT301")]

struct HomeView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color("light_gray")
                .edgesIgnoringSafeArea(.top)
            GeometryReader { geometry in
                // Courses Text
                Text("Courses")
                    .font(.title2)
                    .bold()
                    .background(RoundedRectangle(cornerRadius: 25.0)
                                    .stroke()
                                    .frame(width: 150, height: 50)
                    )
                    .position(x: geometry.size.width / 2, y: 70)
                
                // Courses selection
                getCoursesView(for: geometry)
                
                // Add button
                Button(action: {
                    print("Add clicked!")
                    if getCourses().count >= 6 {
                        showingAlert = true
                    } else {
                        // TODO: add a course
                        addCourse(course: CourseItem(name: "ADD101"))
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.black)
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Exceed Maximum Courses"),
                          message: Text("Currently do not support adding more than 6 courses"), dismissButton: .default(Text("OK")))
                }
                .position(x: geometry.size.width - 60, y: geometry.size.height - 60)
            }
        }
    }
}


let layout = [GridItem(.adaptive(minimum: 150))]

struct CoursesView: View {
    let courses = getCourses()

    var body: some View {
            LazyVGrid(columns: layout, spacing: 70) {
                ForEach(courses, id: \.self) { course in
                    NavigationLink(destination: CourseChatView(course: course)){
                        Text(course.name)
                            .foregroundColor(.black)
                            .font(.title2)
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black)
                                            .frame(width: 150, height: 60)
                            )
                    }
                    .padding()
                }
            }
    }
}


private func getCoursesView(for metrics: GeometryProxy) -> some View {
    return CoursesView()
        .position(x: metrics.size.width / 2, y: metrics.size.height / 2)
}

private func addCourse(course: CourseItem) {
    courses.append(course)
}

private func getCourses() -> Array<CourseItem> {
    return courses
}

private func fetchCourses() -> Array<CourseItem> {
    // TODO: hard code
    return courses
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
