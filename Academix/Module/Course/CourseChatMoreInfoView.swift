//
//  CourseChatMoreInfoView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct CourseChatMoreInfoView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var course: Course
    @Binding var deleted: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("name: \(course.name)")
            Text("id: \(course.id)")
            Spacer()
            Button(action: {
                removeCourse()
            }) {
                Text("Remove \(course.name)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.red)
                                    .frame(width: 200, height: 50))
            }
            .padding(.vertical, 30)
        }
    }
    
    func removeCourse() {
        viewModel.removeCourse(course)
        self.presentationMode.wrappedValue.dismiss()
        deleted = true
    }
}

//struct CourseChatMoreInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseChatMoreInfoView(course: .cscc10)
//    }
//}
