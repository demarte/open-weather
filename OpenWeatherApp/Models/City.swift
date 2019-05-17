//
//  City.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct City: Codable {
  enum CodingKeys: String, CodingKey {
    case iconStatus = "weather"
    case weather = "main"
    case weatherTime = "sys"
    case name, wind
  }
  let name: String
  let iconStatus: [IconStatus]
  let weather: Weather
  let wind: Wind
  let weatherTime: WeatherTime
}
