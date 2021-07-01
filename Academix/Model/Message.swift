//
//  Message.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation
import Firebase

struct Message: Identifiable, Equatable, Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }

    var id = UUID().uuidString
    let timestamp: Date
    let sender: User.ID
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case sender
        case timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
//    func send() {
//        let db = Firestore.firestore()
//        let uid = Auth.auth().currentUser?.uid
//
//    }
}

extension Message {
    static let all: [Message] = [
        Message(
            timestamp: Date(),
            sender: User.guest.id,
            text: Chat.me.desc
        )
    ]
}
