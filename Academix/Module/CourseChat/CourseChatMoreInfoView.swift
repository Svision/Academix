//
//  CourseChatMoreInfoView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct CourseChatMoreInfoView: View {
    let course: CourseModel
    
    var body: some View {
        VStack {
            Text("name: \(course.name)")
            Text("id: \(course.id)")
        }
    }
}

struct CourseChatMoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CourseChatMoreInfoView(course: .cscc10)
    }
}
