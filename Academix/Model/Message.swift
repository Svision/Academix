//
//  Message.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct Message: Identifiable, Equatable  {
    var id = UUID()
    let createdAt: Double?
    let image: Media?
    let user: User
    let text: String?
    let type: MessageType
    let voice: String?
    let video: Media?
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    enum MessageType: String, Codable, Equatable {
        case text
        case image
        case voice
        case video
    }
}
