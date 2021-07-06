//
//  CourseModel.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation
import SwiftUI
import Firebase

class Course: Hashable, Identifiable, ObservableObject, Codable  {
    let name: String
    let university: String
    let department: String
    let courseCode: String
    let courseDesc: String
    let id: String
    var students: Array<User> = []
    
    enum CodingKeys: String, CodingKey {
        case name
        case university
        case department
        case courseCode
        case courseDesc
        case id
        case students
        case messages
        case unreadMessages
    }
    
    @Published var messages: Array<Message> = []
    @Published var unreadMessages: Int = 0
    
    init(university: String, department: String, courseCode: String, courseDesc: String = "") {
        self.name = department + courseCode
        self.university = university
        self.department = department
        self.courseCode = courseCode
        self.courseDesc = courseDesc
        self.id = "\(university).\(department).\(courseCode)"
    }
    
    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func userReaded() {
        let ref = Firestore.firestore()
        ref.collection("Messages").document("UnreadMessages").collection("Courses")
            .document(id).collection(id)
    }
    
    func fetchAllMessages() {
        let ref = Firestore.firestore()
        ref.collection("Messages").document("Messages").collection("Courses")
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
                    let sender = doc.document.get("sender") as! String
                    let timestamp: Timestamp = doc.document.get("timestamp") as! Timestamp

                    DispatchQueue.main.async {
                        let msg = Message(id: id, timestamp: timestamp.dateValue(), sender: sender, text: text)
                        if !self.messages.contains(msg) {
                            self.messages.append(msg)
                            let myId = UserDefaults.standard.getObject(forKey: defaultsKeys.currUser, castTo: User.self)!.id
                            if msg.sender != myId {
                                self.unreadMessages += 1
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Course {
    static var all: [Course] = [general, cscc10, csc369, csc373, sta301, mat301]
    
    static var general = Course(
        university: "Academix",
        department: "General",
        courseCode: ""
    )
    
    static let cscc10 = Course(
        university: "UofT",
        department: "CSC",
        courseCode: "C10"
    )
    
    static let csc369 = Course(
        university: "UofT",
        department: "CSC",
        courseCode: "369"
    )
    
    static let csc373 = Course(
        university: "UofT",
        department: "CSC",
        courseCode: "373"
    )
    
    static let sta301 = Course(
        university: "UofT",
        department: "STA",
        courseCode: "301"
    )
    
    static let mat301 = Course(
        university: "UofT",
        department: "MAT",
        courseCode: "301"
    )
}
