//
//  CityServiceType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol WeatherServiceType {
  func cityWeather(for searchTerm: String, completion: @escaping (Result<City>) -> Void)
}
