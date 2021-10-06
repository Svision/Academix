//
//  CourseCardView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-02.
//

import SwiftUI

struct CourseCardView: View {
    let courseName: String
    let courseDesc: String
    
    var body: some View {
        VStack {
            Text(courseName)
                .font(.title2)
                .bold()
                .foregroundColor(Color("theme_blue"))
                .frame(width: 150, height: 60)
        }
    }
}

struct CourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView(courseName: "CSC263", courseDesc: "")
    }
}
