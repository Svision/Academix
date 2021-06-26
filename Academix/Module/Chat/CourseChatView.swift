//
//  CourseChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI
import Combine

struct CourseChatView: View {
    let course: CourseItem
    @State var uiTabarController: UITabBarController?
    
    var btnMore : some View { Button(action: {
        // TODO: more
        }) {
            Image(systemName: "ellipsis") // back button
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Temporary solution for navigationbarTitile in iOS 15
                if #available(iOS 15, *) {
                    Text(course.name).zIndex(1).position(x: proxy.size.width / 2, y: -20.0)
                }
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    Spacer()
                    Text("courseId: \(course.id)")
                    Spacer()
                    ChatSendBar(proxy: proxy)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .navigationBarTitle(course.name, displayMode: .inline)
        .navigationBarItems(trailing: btnMore)
    }
}

struct CourseDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        let testCourse = CourseItem(name: "CSCC10")
        NavigationView { CourseChatView(course: testCourse) }
    }
}
