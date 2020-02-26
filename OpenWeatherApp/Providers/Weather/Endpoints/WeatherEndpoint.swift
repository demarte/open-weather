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
  case cityWeatherByCoordinates(lat: Float, lon: Float)
  case cityWeatherForecast(searchTerm: String)
}

extension WeatherEndpoint: EndpointType {
  var path: String {
    switch self {
    case .cityWeatherByCoordinates:
      return "weather"
    case .cityWeatherBySearchTerm:
      return "find"
    case .cityWeatherForecast:
      return "forecast"
    }
  }

  var method: Method {
    return .get
  }

  var parameters: [String: String]? {
    var parameters: [String: String] = ["APPID": Constants.apiKey]
    switch self {
    case .cityWeatherByCoordinates(let lat, let lon):
      parameters["lat"] = "\(lat)"
      parameters["lon"] = "\(lon)"
    case .cityWeatherBySearchTerm(let searchTerm):
      parameters["q"] = searchTerm
    case .cityWeatherForecast(let searchTerm):
      parameters["q"] = searchTerm
    }
    return parameters
  }
}
