//
//  WeatherProviderRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct WeatherProviderRestAPI: WeatherProviderType {
  let apiRequester = APIRequester<WeatherEndpoint>()
  func cityWeather(for searchTerm: String, completion: @escaping ((Result<City>) -> Void)) {
    apiRequester.request(.cityWeatherBySearchTerm(searchTerm: searchTerm), completion: completion)
  }
}
