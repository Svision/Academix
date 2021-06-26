//
//  User.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation

struct User: Identifiable, Codable {
    // basic info
    var name: String
    var avatar: String
    var university: String
    let id: String // email == id
    
    // setting
    var major: String = ""
    var url: String = ""
    
    // relation
    var friends: Array<User> = []
    
    init(name: String, avatar: String, university: String, email: String) {
        self.name = name
        self.avatar = avatar
        self.university = university
        self.id = email
    }
    
}

extension User {
    static let me = User(
        name: "Shawn",
        avatar: "data_avatar1",
        university: "UofT",
        email: "changhao.song@mail.utoronto.ca"
    )
    
    static let amanda = User(
        name: "Amanda",
        avatar: "data_avatar2",
        university: "UofT",
        email: "wenqing.cao@mail.utoronto.ca"
    )
    
    static let sky = User(
        name: "sky",
        avatar: "data_avatar3",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
    
    static let yuhong = User(
        name: "Yuhong",
        avatar: "data_avatar4",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
    
    static let meixuan = User(
        name: "Meixuan",
        avatar: "data_avatar5",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
    
    static let xiaoning = User(
        name: "Xiaoning",
        avatar: "data_avatar6",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
    
    static let yitong = User(
        name: "Yitong",
        avatar: "data_avatar7",
        university: "UofT",
        email: "@mail.utoronto.ca"
    )
}
