//
//  WeatherEndpoint.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/14/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

enum WeatherEndpoint {
  case cityWeatherBySearchTerm(searchTerm: String)
  case cityWeatherByCoordinates(lat: String, long: String)
}

extension WeatherEndpoint: EndpointType {
  var path: String {
    return "weather"
  }
  var method: Method {
    return .get
  }
  var parameters: [String: String]? {
    var parameters: [String: String] = ["APPID": Constants.apiKey]
    switch self {
    case .cityWeatherByCoordinates(let lat, let long):
      parameters["latitude"] = "\(lat)"
      parameters["longitude"] = "\(long)"
    case .cityWeatherBySearchTerm(let searchTerm):
      parameters["q"] = searchTerm
    }
  }
}
