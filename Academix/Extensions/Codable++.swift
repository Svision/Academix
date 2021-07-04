//
//  Codable++.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-03.
//

import Foundation

extension Encodable {
    func saveSelf(forKey id: String) {
        do {
            try UserDefaults.standard.setObject(self, forKey: id)
        } catch {
            print("---- update error ----")
            print(error.localizedDescription)
        }
    }
}
