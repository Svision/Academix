//
//  CourseChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI

struct CourseChatView: View {
    let course: CourseItem
    @State var uiTabarController: UITabBarController?
    
    var btnMore : some View { Button(action: {
        }) {
            Image(systemName: "ellipsis") // back button
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        ZStack {
            Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255)
                .ignoresSafeArea()
            Text(course.name)
                .font(.largeTitle)
        }
        .navigationTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: btnMore)
    }
}

struct CourseDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseChatView(course: CourseItem(name: "CSCC10"))
        }
    }
}
