//
//  FriendsMoreInfoView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import SwiftUI

struct FriendsMoreInfoView: View {
    let friend: User
    
    var body: some View {
        VStack {
            Text("name: \(friend.name)")
            Text("id: \(friend.id)")
            Text("university: \(friend.university)")
        }
        
    }
}

struct FriendsMoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsMoreInfoView(friend: .amanda)
    }
}
