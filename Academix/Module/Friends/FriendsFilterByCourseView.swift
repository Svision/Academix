//
//  FriendsFilterByCourseView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI

struct FriendsFilterByCourseView: View {
    @Binding var selected : String
    @Binding var courses: [Course]
    private let spacing: CGFloat = 20.0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(courses) { course in
                        Button(action: {
                            if selected == course.name {
                                selected = ""
                            } else {
                                selected = course.name
                            }
                        }) {
                            Text(course.name)
                                .foregroundColor(selected == course.name ? .red : .gray)
                                .padding(.horizontal, 10)
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.primary)
                                                .frame(height: 20)
                                )
                        }
                    }
                }
                .padding(.horizontal, spacing)
                .frame(height: 30)
            }
            .frame(height: 50)
            Separator()
        }

    }
}

//struct FriendsFilterByCourse_Previews: PreviewProvider {
//    @State static var selected = ""
//    static var previews: some View {
//        FriendsFilterByCourse(selected: $selected)
//    }
//}
