//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct Weather: Codable {
  enum CodingKeys: String, CodingKey {
    case type = "main"
    case urlIcon = "icon"
    case description
  }
  let type: String
  let description: String
  let urlIcon: String
}
