//
//  FriendsChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI
import Firebase
import CoreHaptics

struct FriendsChatView: View {
    @ObservedObject var chat: FriendChat
    @State var isMoreInfoViewActive: Bool = false
    @State private var engine: CHHapticEngine?
    
    var moreInfoView : some View {
        NavigationLink(destination: FriendsMoreInfoView(friend: chat.friend), isActive: $isMoreInfoViewActive) {
            EmptyView()
        }
    }

    var btnMore: some View {
        Button(action: { isMoreInfoViewActive = true }) {
                Image(systemName: "ellipsis") // more button
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 30)) // increase tap area
                    .offset(x: 30)
            }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Separator(color: Color("navigation_separator"))
                Spacer()
                MessageList(messages: $chat.messages)
                    .onAppear { chat.getThisDM() }
                Spacer()
                ChatSendBar(proxy: proxy, toCourses: false, receiver: chat.friend.id)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .background(moreInfoView)
        .navigationBarTitle(chat.friend.name, displayMode: .inline)
        .navigationBarItems(trailing: btnMore)
        .onAppear(perform: prepareHaptics)
        .onChange(of: chat.haveNewMessages, perform: { haveNewMessages in
            if haveNewMessages { complexSuccess() }
            chat.readed()
            chat.saveSelf(forKey: chat.id)
        })
        .onTapGesture {
            self.endTextEditing()
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
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one hapticContinuous
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 0.4)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

//struct FriendsChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsChatView(chat: .amanda)
//    }
//}
