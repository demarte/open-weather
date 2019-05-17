//
//  WeatherTime.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/17/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct WeatherTime: Codable {
  enum CodingKeys: String, CodingKey {
    case sunriseTime = "sunrise"
    case sunsetTime = "sunset"
  }
  let sunriseTime: Int
  let sunsetTime: Int
}
