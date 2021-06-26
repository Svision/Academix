//
//  Media.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-26.
//

import Foundation

struct Media: Codable, Equatable, Identifiable {
    var id = UUID()
    let cover: String?
    let width: Double?
    let height: Double?
    let url: String
}
