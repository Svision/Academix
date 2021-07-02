//
//  CourseModel.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation
import SwiftUI
import Firebase

class CourseModel: Hashable, Identifiable, ObservableObject {
    let name: String
    let university: String
    let department: String
    let courseCode: String
    let courseDesc: String
    var id: String
    var students: Array<User.ID> = []
    @Published var msgs: Array<Message> = []
    @Published var unreadMessages: Int = 0
    
    static func == (lhs: CourseModel, rhs: CourseModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(university: String, department: String, courseCode: String) {
        self.name = department + courseCode
        self.university = university
        self.department = department
        self.courseCode = courseCode
        self.courseDesc = ""
        self.id = "\(university).\(department).\(courseCode)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    func readAllMsgs() {
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
                        if !self.msgs.contains(msg) {
                            self.msgs.append(msg)
                            self.unreadMessages += 1
                        }
                    }
                }
            }
        }
    }
}

extension CourseModel {
    static var all: [CourseModel] = [cscc10, csc369, csc373, sta301, mat301]
    
    static let cscc10 = CourseModel(
        university: "UofT",
        department: "CSC",
        courseCode: "C10"
    )
    
    static let csc369 = CourseModel(
        university: "UofT",
        department: "CSC",
        courseCode: "369"
    )
    
    static let csc373 = CourseModel(
        university: "UofT",
        department: "CSC",
        courseCode: "373"
    )
    
    static let sta301 = CourseModel(
        university: "UofT",
        department: "STA",
        courseCode: "301"
    )
    
    static let mat301 = CourseModel(
        university: "UofT",
        department: "MAT",
        courseCode: "301"
    )
}
