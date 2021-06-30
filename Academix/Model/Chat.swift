//
//  Chat.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation

struct Chat: Identifiable {
    var id = UUID()
    let desc: String
    let sender: User
    let time: Date
}

extension Chat {
    static let all: [Chat] = [
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
    
    static let amanda = Chat(
        desc: "快乐每一天! 享受生活☀️爱身边人",
        sender: .amanda,
        time: Date()
    )
    
    static let me = Chat(
        desc: "Academix is a mobile software that integrates different functionalities that help students in both academic and social aspects.",
        sender: .me,
        time: Date()
    )
    
    static let sky = Chat(
        desc: "(｡ì_í｡)",
        sender: .sky,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let leon = Chat(
        desc: "Hello World!",
        sender: .leon,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let yuhong = Chat(
        desc: "well uneducated",
        sender: .yuhong,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let meixuan = Chat(
        desc: "今いまでもあなたはわたしの光",
        sender: .meixuan,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let xiaoning = Chat(
        desc: "重录版的Jump Then Fall好听! ! !",
        sender: .xiaoning,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let yitong = Chat(
        desc: "✨",
        sender: .yitong,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let owen = Chat(
        desc: "爱生活，爱自己",
        sender: .owen,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
    static let bill = Chat(
        desc: "FUTURE IS THE PAST",
        sender: .bill,
        time: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date().self)!)!
    )
    
}
