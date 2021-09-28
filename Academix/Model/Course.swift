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
    var students: Array<User.ID> = []
    
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
    
    init(university: String, department: String, courseCode: String, courseDesc: String = "", students: Array<User.ID> = []) {
        self.name = department + courseCode
        self.university = university
        self.department = department
        self.courseCode = courseCode
        self.courseDesc = courseDesc
        self.id = "\(university).\(department).\(courseCode)"
        self.students = students
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
                    let senderId = doc.document.get("sender") as! String
                    let timestamp: Timestamp = doc.document.get("timestamp") as! Timestamp

                    AppViewModel.fetchUser(email: senderId) { sender in
                        guard sender != nil else { return }
                        let msg = Message(id: id, timestamp: timestamp.dateValue(), sender: sender!, text: text)
                        if !self.messages.contains(msg) {
                            self.messages.append(msg)
                            let myId = UserDefaults.standard.getObject(forKey: defaultsKeys.currUser, castTo: User.self)!.id
                            if sender!.id != myId {
                                self.unreadMessages += 1
                            }
                        }
                    }

                }
            }
        }
        self.messages.sort(by: { $0.timestamp < $1.timestamp })
    }
    
    func removeStudent(email: String) {
        for (index, student) in self.students.enumerated() {
            if student == email {
                self.students.remove(at: index)
            }
        }
    }
}

extension Course {
    static var all: [Course] = [general]
    
    static var general = Course(
        university: "Academix",
        department: "General",
        courseCode: ""
    )
}
