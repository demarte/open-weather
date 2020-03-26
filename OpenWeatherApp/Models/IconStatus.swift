//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct IconStatus: Decodable {
  enum CodingKeys: String, CodingKey {
    case type = "main"
    case path = "icon"
    case description
  }

  let type: String
  let description: String
  let path: String
  let identifier = UUID().uuidString
}

extension IconStatus: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}

extension IconStatus: Equatable {
  static func == (lhs: IconStatus, rhs: IconStatus) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
