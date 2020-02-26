//
//  WeatherProviderType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol WeatherProviderType {
  func cityWeather(latitude: Float, longitude: Float, completion: @escaping (Result<City>) -> Void)
  func fetchCities(for searchTerm: String, completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void)
  func weatherForecast(for searchTerm: String, completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void)
}
