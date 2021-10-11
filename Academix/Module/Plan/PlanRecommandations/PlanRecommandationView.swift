//
//  PlanRecommandationView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-11.
//

import SwiftUI

struct PlanRecommandationView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var recommandCourses: [Course] = mockRecommandationCourses()
    var recommandReasons: [String] = mockRecommandationReasons()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Recommandations
            Text("Recommandations")
                .font(.title2)
                .foregroundColor(Color("theme_blue"))
                .padding()
            ForEach(recommandCourses.indices) { index in
                PlanRecommandationCourseView(recommandCourse: recommandCourses[index],
                                             recommandReason: recommandReasons[index])
            }
            
            // My Plan
            HStack {
                Text("My Plan:")
                    .font(.title2)
                    .foregroundColor(Color("theme_green"))
                Text(" \(Date().currentTerm)")
                    .font(.title2)
                    .foregroundColor(Color("theme_green"))
            }
            .padding()
            MyPlanView(courses: $viewModel.currUser.courses)
        }
    }
}

private func mockRecommandationCourses() -> [Course] {
    return [Course(university: "UofT",
                   department: "CSC",
                   courseCode: "404",
                   courseDesc: "Video Game Design",
                   students: []),
            Course(university: "UofT",
                           department: "STA",
                           courseCode: "303",
                           courseDesc: "Methods of Data Analysis II",
                           students: []),
            Course(university: "UofT",
                           department: "CSC",
                           courseCode: "309",
                           courseDesc: "Programming on the Web",
                           students: []),
            Course(university: "UofT",
                           department: "CSC",
                           courseCode: "401",
                           courseDesc: "Natrual Language Computing",
                           students: [])]
}

private func mockRecommandationReasons() -> [String] {
    return ["68% students taken CSC318 also taken this",
            "3 of your friends taken this before",
            "Most CS students taken this",
            "Students taken simillar courses also taken this"]
}

struct PlanRecommandationView_Previews: PreviewProvider {
    static var previews: some View {
        PlanRecommandationView()
    }
}
