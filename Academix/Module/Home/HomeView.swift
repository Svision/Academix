//
//  HomeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI
import CoreMedia

struct HomeView: View {
    @State private var showingAlert = false
    @Binding var courses: [Course]
    
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
                        .foregroundColor(Color("theme_blue"))
                        .frame(width: 150, height: 60)
                        .padding(.top, geometry.size.height / 12)
                    
                    // Courses selection
                    CoursesView(courses: $courses, metrics: geometry)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                }
                // Add button
                if courses.count >= 6 {
                    Button(action: {
                        showingAlert = true
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
                else {
                    NavigationLink(destination: AddCourseView()) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.primary)
                    }
                    .position(x: geometry.size.width - 60, y: geometry.size.height - 60)
                }
            }
        }
    }
    
    struct CoursesView: View {
        @EnvironmentObject var viewModel: AppViewModel
        @Binding var courses: [Course]
        let metrics: GeometryProxy
        let layout = [GridItem(.adaptive(minimum: 150))]

        var body: some View {
            LazyVGrid(columns: layout, spacing: metrics.size.height / 8) {
                ForEach(courses, id: \.id) { course in
                    NavigationLink(destination: CourseChatView(course: course).onAppear {
                        course.unreadMessages = 0
                        viewModel.currUser.saveSelf(forKey: defaultsKeys.currUser)
                    }){
                        CourseEntryView(course: course)
                    }
                    .padding()
                }
            }
            .onAppear(perform: sortCourses)
        }
        
        func sortCourses() {
            courses.sort { (course1, course2) -> Bool in
                return (course1.courseCode < course2.courseCode)
            }
        }
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
