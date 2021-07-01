//
//  CourseItem.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-24.
//

import Foundation
import SwiftUI
import Firebase

struct CourseItem: Hashable, Identifiable {
    let name: String
    let university: String
    let department: String
    let courseCode: String
    let courseDesc: String
    var id: String
    var students: Array<User.ID> = []
    let ref = Firestore.firestore()
    @State var msgs: Array<Message> = []
    
    static func == (lhs: CourseItem, rhs: CourseItem) -> Bool {
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
    
    func readAll() {
        ref.collection("Msgs").addSnapshotListener { snap, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach { doc in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let text = doc.document.get("text") as! String
                    let sender = doc.document.get("user") as! String
                    let timestamp = doc.document.get("timestamp") as! Date

                    DispatchQueue.main.async {
                        self.msgs.append(Message(id: id, timestamp: timestamp, sender: sender, text: text))
                    }
                }
            }
        }
    }
}

extension CourseItem {
    static let all: [CourseItem] = [cscc10, csc369, csc373, sta301, mat301]
    
    static let cscc10 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "C10"
    )
    
    static let csc369 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "369"
    )
    
    static let csc373 = CourseItem(
        university: "UofT",
        department: "CSC",
        courseCode: "373"
    )
    
    static let sta301 = CourseItem(
        university: "UofT",
        department: "STA",
        courseCode: "301"
    )
    
    static let mat301 = CourseItem(
        university: "UofT",
        department: "MAT",
        courseCode: "301"
    )
}
