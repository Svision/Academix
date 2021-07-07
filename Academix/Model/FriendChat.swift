//
//  FriendChat.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation
import Firebase

class FriendChat: Identifiable, ObservableObject, Equatable, Codable  {
    var id: String
    @Published var messages: Array<Message> = []
    let friend: User
    let myId: String
    @Published var unreadMessages: Int = 0
    @Published var haveNewMessages: Bool = false
    static func == (lhs: FriendChat, rhs: FriendChat) -> Bool {
        lhs.id == rhs.id
    }
    
    init(myId: String, friend: User) {
        self.friend = friend
        self.myId = myId
        id = myId < friend.id ? "\(myId)&\(friend.id)" : "\(friend.id)&\(myId)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case messages
        case friend
        case myId
        case unreadMessages
        case haveNewMessages
    }
    
    func lastMessage() -> Message {
        if messages.last != nil {
            return messages.last!
        }
        return Message(timestamp: Date(timeIntervalSince1970: 0), senderId: friend.id)
    }
    
    func readed() {
        self.unreadMessages = 0
        self.haveNewMessages = false
    }
    
    func getThisDM() {
        let ref = Firestore.firestore()
        ref.collection("Messages").document("Messages").collection("DMs")
            .document(id).collection(id).order(by: "timestamp").addSnapshotListener { snap, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach { doc in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let text = doc.document.get("text") as! String
                    let senderId = doc.document.get("sender") as! String
                    let timestamp: Timestamp = doc.document.get("timestamp") as! Timestamp

                    DispatchQueue.main.async {
                        let msg = Message(id: id, timestamp: timestamp.dateValue(), senderId: senderId, text: text)
                        if !self.messages.contains(msg) {
                            self.messages.append(msg)
                            if senderId != self.myId {
                                self.unreadMessages += 1
                                self.haveNewMessages = true
                            }
                        }
                    }
                }
            }
        }
    }
}
