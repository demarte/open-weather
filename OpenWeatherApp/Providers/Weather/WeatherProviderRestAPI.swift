//
//  WeatherProviderRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct WeatherProviderRestAPI: WeatherProviderType {
  let weatherRequester = APIRequester<WeatherEndpoint>()

  func cityWeather(latitude: Float, longitude: Float, completion: @escaping (Result<City>) -> Void) {
    weatherRequester.request(.cityWeatherByCoordinates(lat: latitude, lon: longitude), completion: completion)
  }

  func fetchCities(for searchTerm: String, completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void) {
    weatherRequester.request(.cityWeatherBySearchTerm(searchTerm: searchTerm), completion: completion)
  }

  func weatherForecast(
    latitude: Float,
    longitude: Float,
    completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void) {
    weatherRequester.request(.cityWeatherForecast(lat: latitude, lon: longitude), completion: completion)
  }
}
