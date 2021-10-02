//
//  Date++.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation

private let yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/M/d"
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

extension Date {
    var formatString: String {
        let date = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self, to: date)
        
        if components.year! >= 1 || components.month! >= 1 || components.day! > 1 {
            return "\(yearFormatter.string(from: self)) \(timeFormatter.string(from: self))"
        } else if components.day! >= 1 && components.day! < 2 {
            return "yesterday \(timeFormatter.string(from: self))"
        } else {
            return timeFormatter.string(from: self)
        }
    }
}
