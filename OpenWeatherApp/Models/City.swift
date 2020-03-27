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
    case dateTime = "dt"
    case name, wind, coord
  }

  enum Coordinates: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }

  enum Wind: String, CodingKey {
    case speed
  }

  enum Country: String, CodingKey {
    case country
  }

  let name: String?
  let iconStatus: [IconStatus]
  let weather: Weather
  let windSpeed: Double
  let latitude: Float?
  let longitude: Float?
  let country: String?
  let dateTime: Int?
  let identifier = UUID().uuidString
  var time: String {
    guard let dateTime = self.dateTime else {
      return ""
    }
    let date = Date(timeIntervalSince1970: TimeInterval(dateTime))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    if date.compare(Date()) == .orderedSame {
      return "now"
    } else {
      return dateFormatter.string(from: date)
    }
  }
  var date: String {
    guard let dateTime = self.dateTime else {
      return ""
    }
    let date = Date(timeIntervalSince1970: TimeInterval(dateTime))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    return dateFormatter.string(from: date)
  }
}

extension City: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    if values.contains(.name) {
      name = try values.decode(String.self, forKey: .name)
    } else {
      name = nil
    }
    if values.contains(.dateTime) {
      dateTime = try values.decode(Int.self, forKey: .dateTime)
    } else {
      dateTime = nil
    }
    iconStatus = try values.decode([IconStatus].self, forKey: .iconStatus)
    weather = try values.decode(Weather.self, forKey: .weather)

    let windContainer = try values.nestedContainer(keyedBy: Wind.self, forKey: .wind)
    windSpeed = try windContainer.decode(Double.self, forKey: .speed)

    let countryContainer = try values.nestedContainer(keyedBy: Country.self, forKey: .country)
    if countryContainer.contains(.country) {
      country = try countryContainer.decode(String.self, forKey: .country)
    } else {
      country = nil
    }

    if values.contains(.coord) {
      let coordinates = try values.nestedContainer(keyedBy: Coordinates.self, forKey: .coord)
      latitude = try coordinates.decode(Float.self, forKey: .latitude)
      longitude = try coordinates.decode(Float.self, forKey: .longitude)
    } else {
      latitude = nil
      longitude = nil
    }
  }
}

extension City: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}

extension City: Equatable {
  static func == (lhs: City, rhs: City) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
