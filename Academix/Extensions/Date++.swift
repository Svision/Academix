//
//  Date++.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation

private let yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var formatString: String {
        let currDate = Date()
        if Calendar.current.isDateInToday(self) {
            return timeFormatter.string(from: self)
        } else if Calendar.current.isDateInYesterday(self) {
            return NSLocalizedString("Yesterday", comment: "") + " " + "\(timeFormatter.string(from: self))"
        } else if Calendar.current.isDate(self, equalTo: currDate, toGranularity: .year){
            return "\(yearFormatter.string(from: self))".subString(from: 5)
        } else {
            return "\(yearFormatter.string(from: self))"
        }
    }
}
