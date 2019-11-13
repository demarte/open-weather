//
//  CityServiceRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct WeatherServiceRestAPI: WeatherServiceType {
  private let weatherProvider: WeatherProviderType

  init(weatherProvider: WeatherProviderType = WeatherProviderRestAPI()) {
    self.weatherProvider = weatherProvider
  }

  func cityWeather(for searchTerm: String, completion: @escaping (Result<City>) -> Void) {
    weatherProvider.cityWeather(for: searchTerm, completion: completion)
  }

  func fetchCities(for searchTerm: String, completion: @escaping (Result<WeatherResult>) -> Void) {
    weatherProvider.fetchCities(for: searchTerm, completion: completion)
  }
}
