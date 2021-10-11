//
//  PlanRecommandationCourseView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-11.
//

import SwiftUI

struct PlanRecommandationCourseView: View {
    var recommandCourse: Course
    var recommandReason: String
    
    var body: some View {
        HStack {
            Text(recommandCourse.name)
                .foregroundColor(.primary)
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color("inverse_primary"))
                                .frame(width: 120, height: 40))
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary)
                            .frame(width: 120, height: 40))
                .frame(width: 120, height: 40)
                .padding()
            
            Text(recommandReason)
                .foregroundColor(.secondary)
                .font(.caption)
                .underline(true, color: .secondary)
                .frame(width: 120)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("+")
                .font(.title)
                .padding()
        }
    }
}

struct PlanRecommandationCourseView_Previews: PreviewProvider {
    static var CSC404 = Course(university: "UofT",
                        department: "CSC",
                        courseCode: "404",
                        courseDesc: "Video Game Design",
                        students: [])
    static var recommandReason = "68% taken CSC318 also taken this"
    static var previews: some View {
        PlanRecommandationCourseView(recommandCourse: CSC404, recommandReason: recommandReason)
    }
}
