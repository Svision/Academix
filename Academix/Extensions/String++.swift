//
//  String++.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import Foundation

extension String {
    func subString(from: Int = 0, to: Int = -1) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to == -1 ? self.count : to)
        return String(self[startIndex..<endIndex])
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isAlpha: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
}
