//
//  HomeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct HomeView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color("light_gray")
                .edgesIgnoringSafeArea(.top)
            GeometryReader { geometry in
                // Courses Text
                VStack {
                    Text("Courses")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(red: 71/255, green: 192/255, blue: 231/255))
                        .frame(width: 150, height: 60)
                        .padding(.top, geometry.size.height / 12)
                    
                    // Courses selection
                    CoursesView(metrics: geometry)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                }
                // Add button
                Button(action: {
                    print("Add clicked!")
                    if getCourses().count >= 6 {
                        showingAlert = true
                    } else {
                        // TODO: add a course
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.primary)
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
    let metrics: GeometryProxy

    var body: some View {
        LazyVGrid(columns: layout, spacing: metrics.size.height / 8) {
                ForEach(courses, id: \.self) { course in
                    NavigationLink(destination: CourseChatView(course: course)){
                        Text(course.name)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary)
                                            .frame(width: 150, height: 60)
                            )
                    }
                    .padding()
                }
            }
    }
}

//private func addCourse(course: CourseItem) {
//    courses.append(course)
//}

private func getCourses() -> Array<CourseItem> {
    return CourseItem.all
}

//private func fetchCourses() -> Array<CourseItem> {
//    // TODO: hard code
//    return courses
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
