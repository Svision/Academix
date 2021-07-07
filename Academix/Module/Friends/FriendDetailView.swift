//
//  FriendDetailView.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-07.
//

import SwiftUI

struct FriendDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let friend: User
    
    var body: some View {
        VStack {
            Spacer()
            Text("name: \(friend.name)")
            Text("id: \(friend.id)")
            Text("university: \(friend.university)")
            Text("courses: \(friend.getCoursesString())")
            Spacer()
            if User.findUser(id: friend.id).id != "unknown@academix.com" {
                if !viewModel.currUser.friends.contains(friend) {
                    Button(action: {
                        addFriend()
                    }) {
                        Text("Add Friend")
                            .foregroundColor(.white)
                            .font(.title2)
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color("theme_blue"))
                                            .frame(width: 200, height: 50))
                    }
                    .padding(.vertical, 30)
                }
                else {
                    Text("Friend Added")
                        .foregroundColor(.primary)
                        .font(.title2)
                        .padding(.vertical, 30)
                }
            }
        }
    }
    
    func addFriend() {
        if viewModel.addNewFriend(friend.id) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
