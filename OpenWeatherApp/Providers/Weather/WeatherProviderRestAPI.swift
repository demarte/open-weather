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
  let citiesRequester = APIRequester<FetchCitiesEndpoint>()

  func cityWeather(for searchTerm: String, completion: @escaping ((Result<City>) -> Void)) {
    weatherRequester.request(.cityWeatherBySearchTerm(searchTerm: searchTerm), completion: completion)
  }

  func fetchCities(for searchTerm: String, completion: @escaping ((Result<WeatherResult>) -> Void)) {
    citiesRequester.request(FetchCitiesEndpoint.citiesBySearchTerm(searchTerm: searchTerm), completion: completion)
  }
}
