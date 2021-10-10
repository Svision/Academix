//
//  AllCourseStudentsView.swift
//  Academix
//
//  Created by Changhao Song on 2021-10-10.
//

import SwiftUI

struct AllCourseStudentsView: View {
    @Binding var courseStudents: [User]
    let layout = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Separator()
                ScrollView {
                    LazyVGrid(columns: layout, spacing: proxy.size.height / 20) {
                        ForEach(courseStudents, id: \.id) { student in
                            NavigationLink(destination: FriendDetailView(friend: student)) {
                                VStack {
                                    Avatar(icon: student.avatar, size: 60)
                                    Text(student.name)
                                        .lineLimit(1)
                                        .allowsTightening(true)
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle(NSLocalizedString("Members", comment: "") + " (\(courseStudents.count))")
    }
}
