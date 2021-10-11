//
//  CourseChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI
import Combine

struct CourseChatView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var course: Course
    @State private var isMoreInfoViewActive: Bool = false
    @State var deleted: Bool = false
    @State var courseStudents: [User] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var scrollToBottom = false
    
    var moreInfoView : some View {
        NavigationLink(destination: CourseChatMoreInfoView(course: course, deleted: $deleted, courseStudents: $courseStudents), isActive: $isMoreInfoViewActive) {
            EmptyView()
        }
    }
    
    var btnMore: some View {
        Button(action: { isMoreInfoViewActive = true }) {
            Image(systemName: "ellipsis") // more button
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 30)) // increase tap area
                .offset(x: 30)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Separator(color: Color("navigation_separator"))
                MessageListView(messages: $course.messages, scrollToBottom: $scrollToBottom)
                    .onAppear(perform: { course.fetchAllMessages() })
                ChatSendBar(proxy: proxy, toCourses: true, receiver: course.id)
                    .onTapGesture { scrollToBottom.toggle() }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .background(moreInfoView)
        .navigationBarTitle(course.name, displayMode: .inline)
        .navigationBarItems(trailing: btnMore)
        .onTapGesture {
            self.endTextEditing()
        }
        .onChange(of: deleted, perform: { value in
            if deleted {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .onAppear {
            DispatchQueue.main.async {
                AppViewModel.fetchCourse(courseId: course.id) { fetchedCourse in
                    if fetchedCourse == nil { return }
                    for course in viewModel.currUser.courses {
                        if course.id == fetchedCourse!.id {
                            course.students = fetchedCourse!.students
                            course.courseDesc = fetchedCourse!.courseDesc
                            viewModel.currUser.saveSelf(forKey: defaultsKeys.currUser)
                            break
                        }
                    }
                
                    for studentID in fetchedCourse!.students {
                        AppViewModel.fetchUser(email: studentID) { user in
                            if user != nil && !self.courseStudents.contains(user!) {
                                self.courseStudents.append(user!)
                                self.courseStudents.sort { (s1, s2) -> Bool in
                                    return (s1.name < s2.name)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    init(course: Course) {
        self.course = course
    }
    
}

//struct CourseDiscussionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView { CourseChatView(course: .cscc10) }
//    }
//}
