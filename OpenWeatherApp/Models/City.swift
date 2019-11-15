//
//  City.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct City {
  enum CodingKeys: String, CodingKey {
    case iconStatus = "weather"
    case weather = "main"
    case country = "sys"
    case name, wind, coord
  }

  enum Coordinates: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }

  enum Wind: String, CodingKey {
    case speed
    case degree = "deg"
  }

  enum Country: String, CodingKey {
    case country
  }

  let name: String
  let iconStatus: [IconStatus]
  let weather: Weather
  let windSpeed: Double
  let windDegree: Double
  let latitude: Double
  let longitude: Double
  let country: String
}

extension City: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name = try values.decode(String.self, forKey: .name)
    iconStatus = try values.decode([IconStatus].self, forKey: .iconStatus)
    weather = try values.decode(Weather.self, forKey: .weather)

    let windContainer = try values.nestedContainer(keyedBy: Wind.self, forKey: .wind)
    windSpeed = try windContainer.decode(Double.self, forKey: .speed)
    windDegree = try windContainer.decode(Double.self, forKey: .degree)

    let countryContainer = try values.nestedContainer(keyedBy: Country.self, forKey: .country)
    country = try countryContainer.decode(String.self, forKey: .country)

    let coordinates = try values.nestedContainer(keyedBy: Coordinates.self, forKey: .coord)
    latitude = try coordinates.decode(Double.self, forKey: .latitude)
    longitude = try coordinates.decode(Double.self, forKey: .longitude)
  }
}
