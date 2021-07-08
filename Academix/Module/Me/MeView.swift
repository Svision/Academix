//
//  MeView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct MeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let defaults = UserDefaults.standard
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("light_gray")
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    Spacer()
                    Image(viewModel.currUser.avatar)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke())
                        .padding()
                    Text("Name: \(viewModel.currUser.name)")
                        .padding()
                    Text("My email: \(viewModel.currUser.id)")
                        .padding()
                    Text("University: \(viewModel.currUser.university)")
                        .padding()
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .padding()
                    }
                    .background(Color.secondary)
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

//struct MeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeView()
//    }
//}
