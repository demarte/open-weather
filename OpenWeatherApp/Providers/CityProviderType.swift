//
//  CityProviderType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol CityProviderType {
  func cityWeather(for searchTerm: String, completion: @escaping (City) -> Void)
}
