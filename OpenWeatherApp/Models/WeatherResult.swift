//
//  Result.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct WeatherResult: Decodable {
  enum CodingKeys: String, CodingKey {
    case cities = "list"
  }
  let cities: [City]
}
