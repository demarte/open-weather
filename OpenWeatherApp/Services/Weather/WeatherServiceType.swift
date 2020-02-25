//
//  CityServiceType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherServiceType {
  func cityWeather(for latitude: CGFloat, longitude: CGFloat, completion: @escaping (Result<City>) -> Void)
  func fetchCities(for searchTerm: String, completion: @escaping (Result<WeatherResult>) -> Void)
}
