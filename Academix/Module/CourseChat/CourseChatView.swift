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
    @State private var isMoreInfoViewActive = false
    
    var moreInfoView : some View {
        NavigationLink(destination: CourseChatMoreInfoView(course: course), isActive: $isMoreInfoViewActive) {
            EmptyView()
        }
    }
    
    var btnMore : some View { Button(action: { isMoreInfoViewActive = true }) {
            Image(systemName: "ellipsis") // more button
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    Spacer()
                    ChatSendBar(proxy: proxy)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color("light_gray"))
            .background(moreInfoView)
            .navigationBarTitle(course.name, displayMode: .inline)
            .navigationBarItems(trailing: btnMore)
    }
}

struct CourseDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { CourseChatView(course: .cscc10) }
    }
}
