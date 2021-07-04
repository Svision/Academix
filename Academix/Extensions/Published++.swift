//
//  Published++.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-03.
//

import Foundation

extension Published: Codable where Value : Codable {
  
  public func encode(to encoder: Encoder) {
    var copy = self
    _ = copy.projectedValue
        .sink(receiveValue: { (value) in
          do {
            try value.encode(to: encoder)
          } catch {
            // handle encoding error
              print(error.localizedDescription)
          }
        })
  }
  
  public init(from decoder: Decoder) throws {
    self.init(wrappedValue: try Value.init(from: decoder))
  }
  
}
