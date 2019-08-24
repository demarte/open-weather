//
//  Main.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/16/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct Weather: Codable {
  enum CodingKeys: String, CodingKey {
    case temperature = "temp"
    case minimumTemperature = "temp_min"
    case maximumTemperature = "temp_max"
    case pressure, humidity
  }

  let temperature: Double
  let pressure: Int
  let humidity: Int
  let minimumTemperature: Double
  let maximumTemperature: Double
}
