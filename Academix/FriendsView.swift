//
//  FriendsView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        ZStack {
            Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255)
                .edgesIgnoringSafeArea(.top)
            Text("Friends")
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
