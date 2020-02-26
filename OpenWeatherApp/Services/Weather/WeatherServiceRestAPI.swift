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

  func cityWeather(latitude: Float, longitude: Float, completion: @escaping (Result<City>) -> Void) {
    weatherProvider.cityWeather(latitude: latitude, longitude: longitude, completion: completion)
  }

  func fetchCities(for searchTerm: String, completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void) {
    weatherProvider.fetchCities(for: searchTerm, completion: completion)
  }

  func weatherForecast(for searchTerm: String, completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void) {
    weatherProvider.weatherForecast(for: searchTerm, completion: completion)
  }
}
