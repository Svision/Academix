//
//  String++.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-27.
//

import Foundation

extension String {
    func subString(from: Int = 0, to: Int) -> String {
       let startIndex = self.index(self.startIndex, offsetBy: from)
       let endIndex = self.index(self.startIndex, offsetBy: to)
       return String(self[startIndex..<endIndex])
    }
}
