//
//  FriendsView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-23.
//

import SwiftUI
import CoreHaptics

struct FriendsView: View {
    @Binding var friendChats: [FriendChat]
    @State var engine: CHHapticEngine?
    @State var selected: String = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("light_gray")
                VStack(spacing: 0) {
                    Separator(color: Color("navigation_separator"))
                    FriendsFilterByCourse(selected: $selected)
                    FriendsChatList(friendChats: $friendChats, selected: $selected, engine: $engine)
                        .onAppear(perform: prepareHaptics)
                }
            }
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
}

//struct FriendsView_Previews: PreviewProvider {
//    @State static var selected = ""
//    static var previews: some View {
//        FriendsView(selected: selected)
//    }
//}
