//
//  City.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct City: Codable {
  let name: String
  let weather: [Weather]
}
