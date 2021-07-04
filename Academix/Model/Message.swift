//
//  Message.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct Message: Identifiable, Equatable, Hashable, Codable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }

    var id = UUID().uuidString
    let timestamp: Date
    let sender: User.ID
    var text: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case sender
        case timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Message {
    static let all: [Message] = [
    ]
}
