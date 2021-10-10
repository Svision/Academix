//
//  CourseChatMoreInfoView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct CourseChatMoreInfoView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var course: Course
    @Binding var deleted: Bool
    @Binding var courseStudents: [User]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                // Course description
                VStack(alignment: .leading) {
                    Separator()
                    HStack {
                        Text("Course description")
                            .bold()
                            .padding()
                        Spacer()
                    }
                    Text(course.courseDesc)
                        .padding(.horizontal)
                }
                
                // Course members
                VStack {
                    Separator()
                    HStack {
                        Text("Course members")
                            .bold()
                            .padding()
                        Spacer()
                    }
                    HStack(spacing: proxy.size.width / 12) {
                        if courseStudents.count <= 4 {
                            ForEach(courseStudents, id: \.id) { student in
                                NavigationLink(destination: FriendDetailView(friend: student)) {
                                    Avatar(icon: student.avatar, size: 60)
                                }
                            }
                        }
                        else {
                            ForEach(courseStudents[..<3], id: \.id) { student in
                                NavigationLink(destination: FriendDetailView(friend: student)) {
                                    Avatar(icon: student.avatar, size: 60)
                                }
                            }
                            NavigationLink(destination: AllCourseStudentsView(courseStudents: $courseStudents)) {
                                Image(systemName: "ellipsis.circle")
                                    .resizable()
                                    .font(Font.title.weight(.ultraLight))
                                    .foregroundColor(.primary)
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                    .padding()
                }
                
                
                // File arvhive
                VStack {
                    Separator()
                    HStack {
                        Text("File archive")
                            .bold()
                            .padding()
                        Spacer()
                    }
                    // TODO
                }
                
                // Message History
                VStack {
                    Separator()
                    HStack {
                        Text("Message History")
                            .padding()
                        Spacer()
                        Image(systemName: "chevron.right.circle")
                            .font(.title3)
                            .padding()
                    }
                    // TODO
                }
                
                
                // Push Notification
                VStack {
                    Separator()
                    HStack {
                        Text("Push Notification")
                            .padding()
                        Spacer()
                        Image(systemName: "bell.slash")
                            .font(.title3)
                            .padding()
                    }
                    // TODO
                    Separator()
                }
                Spacer()
                Text("name: \(course.name)")
                Text("id: \(course.id)")
                Spacer()
                if course.id != "Academix.General." {
                    Button(action: {
                        leaveCourse()
                    }) {
                        Text("Leave \(course.name)")
                            .foregroundColor(.white)
                            .font(.title2)
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.red)
                                            .frame(width: 200, height: 50))
                    }
                    .padding(.vertical, 30)
                }
            }
            .navigationTitle("Course Details")
        }
    }
    
    func leaveCourse() {
        AppViewModel.fetchCourse(courseId: course.id) { getCourse in
            if getCourse != nil {
                getCourse!.removeStudent(email: viewModel.currUser.id)
                viewModel.setCourseDB(course: getCourse!)
            }
        }
        viewModel.removeCourse(course)
        self.presentationMode.wrappedValue.dismiss()
        deleted = true
    }
}

//struct CourseChatMoreInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseChatMoreInfoView(course: .cscc10)
//    }
//}
