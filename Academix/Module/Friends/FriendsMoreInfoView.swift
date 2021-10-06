//
//  FriendsMoreInfoView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct FriendsMoreInfoView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var friend: User
    @Binding var deleted: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("name: \(friend.name)")
            Text("id: \(friend.id)")
            Text("university: \(friend.university)")
            Text("courses: \(friend.getCoursesString())")
            Spacer()
            Button(action: {
                removeFriend()
            }) {
                Text("Remove Friend")
                    .foregroundColor(.white)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.red)
                                    .frame(width: 200, height: 50))
            }
            .padding(.vertical, 30)
        }
    }
    
    func removeFriend() {
        viewModel.removeFriend(friend)
        self.presentationMode.wrappedValue.dismiss()
        deleted = true
    }
}

//struct FriendsMoreInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsMoreInfoView(friend: .amanda)
//    }
//}
