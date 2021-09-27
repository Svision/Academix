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
    let sender: User
    var text: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
