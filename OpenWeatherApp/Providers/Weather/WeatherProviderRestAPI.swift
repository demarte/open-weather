//
//  WeatherProviderRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import UIKit

struct WeatherProviderRestAPI: WeatherProviderType {
  let weatherRequester = APIRequester<WeatherEndpoint>()
  let citiesRequester = APIRequester<FetchCitiesEndpoint>()

  func cityWeather(for latitude: CGFloat, longitude: CGFloat, completion: @escaping ((Result<City>) -> Void)) {
    weatherRequester.request(.cityWeatherByCoordinates(lat: latitude, lon: longitude), completion: completion)
  }

  func fetchCities(for searchTerm: String, completion: @escaping ((Result<WeatherResult>) -> Void)) {
    citiesRequester.request(.citiesBySearchTerm(searchTerm: searchTerm), completion: completion)
  }
}
