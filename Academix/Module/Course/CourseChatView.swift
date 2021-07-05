//
//  CourseChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI
import Combine

struct CourseChatView: View {
    @ObservedObject var course: Course
    @State private var isMoreInfoViewActive: Bool = false
    
    var moreInfoView : some View {
        NavigationLink(destination: CourseChatMoreInfoView(course: course), isActive: $isMoreInfoViewActive) {
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
                MessageList(messages: $course.messages)
                    .onAppear(perform: { course.fetchAllMessages() })
                ChatSendBar(proxy: proxy, toCourses: true, receiver: course.id)
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
