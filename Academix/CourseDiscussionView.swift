//
//  CourseDiscussionView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI

struct CourseDiscussionView: View {
    let course: CourseItem
    @State var uiTabarController: UITabBarController?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward") // back button
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct CourseDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDiscussionView(course: CourseItem(name: "CSCC10"))
        }
    }
}
