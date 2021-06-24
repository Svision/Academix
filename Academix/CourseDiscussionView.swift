//
//  CourseDiscussionView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import SwiftUI

struct CourseDiscussionView: View {
    let course: CourseItem
    
    var body: some View {
        VStack {
            Text(course.name)
                .font(.largeTitle)
        }
        .navigationTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CourseDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDiscussionView(course: CourseItem(name: "CSCC10"))
        }
    }
}
