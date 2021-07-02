//
//  FriendChat.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation
import Firebase

class FriendChat: Identifiable, ObservableObject, Equatable {
    var id = UUID()
    @Published var messages: Array<Message> = []
    let friend: User
    @Published var unreadMessages: Int = 0
    @Published var haveNewMessages: Bool = false
    static func == (lhs: FriendChat, rhs: FriendChat) -> Bool {
        lhs.id == rhs.id
    }
    
    init(sender: User) {
        self.friend = sender
    }
    
    func lastMessage() -> Message {
        if messages.last != nil {
            return messages.last!
        }
        return Message(timestamp: Date(timeIntervalSince1970: 0), sender: friend.id)
    }
    
    func getThisDM() {
        let ref = Firestore.firestore()
        let defaults = UserDefaults.standard
        let me = defaults.string(forKey: defaultsKeys.email)!
        let dest = me < friend.id ? "\(me)&\(friend.id)" : "\(friend.id)&\(me)"
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
                        if !self.messages.contains(msg) {
                            self.messages.append(msg)
                            self.unreadMessages += 1
                            self.haveNewMessages = true
                        }
                    }
                }
            }
        }
    }
}

extension FriendChat {
    static let all: [FriendChat] = [
        amanda,
        me,
        sky,
        leon,
        yuhong,
        meixuan,
        xiaoning,
        yitong,
        owen,
        bill
    ]
    
    static let amanda = FriendChat(
//        desc: "快乐每一天! 享受生活☀️爱身边人",
        sender: .amanda
//        time: Date()
    )
    
    static let me = FriendChat(
//        desc: "Academix is a mobile software that integrates different functionalities that help students in both academic and social aspects.",
        sender: .me
//        time: Date()
    )
    
    static let sky = FriendChat(
//        desc: "(｡ì_í｡)",
        sender: .sky
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let leon = FriendChat(
//        desc: "Hello World!",
        sender: .leon
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let yuhong = FriendChat(
//        desc: "well uneducated",
        sender: .yuhong
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let meixuan = FriendChat(
//        desc: "今いまでもあなたはわたしの光",
        sender: .meixuan
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let xiaoning = FriendChat(
//        desc: "重录版的Jump Then Fall好听! ! !",
        sender: .xiaoning
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let yitong = FriendChat(
//        desc: "✨",
        sender: .yitong
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let owen = FriendChat(
//        desc: "爱生活，爱自己",
        sender: .owen
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let bill = FriendChat(
//        desc: "FUTURE IS THE PAST",
        sender: .bill
//        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
}
