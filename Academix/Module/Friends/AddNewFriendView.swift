//
//  AddNewFriendsButtonView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct AddNewFriendView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email = ""
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Enter Friend Email")
                .font(.title)
            TextField(NSLocalizedString("Email", comment: ""), text: $email)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding()
            Button(action: {
                addFriend()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.title2)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("theme_blue"))
                                    .frame(width: 150, height: 50))
            }
            .padding(.vertical, 30)
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("No User Found"),
                  message: Text("No user founded with given email"), dismissButton: .default(Text("OK")))
        }
        .onTapGesture { self.endTextEditing() }
        .navigationTitle("Add Friend")
    }
    
    func addFriend() {
        AppViewModel.fetchUserFull(email: email) { user in
            if user != nil {
                viewModel.addNewFriend(email)
                email = ""
                self.presentationMode.wrappedValue.dismiss()
            }
            else {
                showingAlert = true
            }
        }
    }
}

struct AddNewFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFriendView()
    }
}
