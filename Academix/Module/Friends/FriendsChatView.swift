//
//  FriendsChatView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import SwiftUI
import Firebase

struct FriendsChatView: View {
    let chat: Chat
    @State var thisDM: Array<Message> = []
    @State var isMoreInfoViewActive: Bool = false
    let defaults = UserDefaults.standard
    
    var moreInfoView : some View {
        NavigationLink(destination: FriendsMoreInfoView(friend: chat.sender), isActive: $isMoreInfoViewActive) {
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
                MessageList(messages: $thisDM)
                    .onAppear { getTwoDMs(sender: defaults.string(forKey: defaultsKeys.email)!, receiver: chat.sender.id) }
                Spacer()
                ChatSendBar(proxy: proxy, toCourses: false, receiver: chat.sender.id)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .background(moreInfoView)
        .navigationBarTitle(chat.sender.name, displayMode: .inline)
        .navigationBarItems(trailing: btnMore)
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    func getTwoDMs(sender: String, receiver: String) {
        let ref = Firestore.firestore()
        let dest = sender < receiver ? "\(sender)&\(receiver)" : "\(receiver)&\(sender)"
        ref.collection("Messages").document("Messages").collection("DMs")
            .document(dest).collection(dest).order(by: "timestamp").addSnapshotListener { snap, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach { doc in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let text = doc.document.get("text") as! String
                    let sender = doc.document.get("sender") as! String
                    let timestamp: Timestamp = doc.document.get("timestamp") as! Timestamp

                    DispatchQueue.main.async {
                        let msg = Message(id: id, timestamp: timestamp.dateValue(), sender: sender, text: text)
                        if !thisDM.contains(msg) {
                            thisDM.append(msg)
                        }
                    }
                }
            }
        }
    }
}

struct FriendsChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsChatView(chat: .amanda)
    }
}
