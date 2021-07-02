//
//  NotificationNumLable.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-02.
//

import SwiftUI

struct NotificationNumLabel: View {
    @Binding var number: Int
    var forCourse: Bool = false
    var capsuleWidth: CGFloat = 12.0
    var capsuleHeight: CGFloat = 18.0
    var chatPosition: CGPoint = CGPoint(x: 43, y: 3)
    var coursePosition: CGPoint = CGPoint(x: 117, y: -15)
    var fontSize: CGFloat = 14.0
    
    @ViewBuilder
    var body: some View {
        if number == 0 {
            EmptyView()
        }
        else {
            ZStack {
                if !forCourse {
                    Capsule().fill(Color.red).frame(width: capsuleWidth * CGFloat(numOfDigits()), height: capsuleHeight, alignment: .topTrailing).position(forCourse ? coursePosition : chatPosition)
                    Text("\(number)")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: fontSize).bold()).position(forCourse ? coursePosition : chatPosition)
                }
                else {
                    Capsule().fill(Color.red).frame(width: capsuleWidth * CGFloat(1.5), height: capsuleHeight, alignment: .topTrailing).position(forCourse ? coursePosition : chatPosition)
                }
            }
        }
    }
    
    func numOfDigits() -> Float {
        let numOfDigits = Float(String(number).count)
        return numOfDigits == 1 ? 1.5 : numOfDigits
    }
}
