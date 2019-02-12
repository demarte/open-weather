//
//  CityServiceRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct CityServiceRestAPI: CityServiceType {
  
  private let cityProvider: CityProviderType
  
  init() {
    cityProvider = CityProviderRestAPI()
  }
  
  func fetch(with searchTerm: String, completion: @escaping (City) -> ()) {
    cityProvider.fetch(with: searchTerm, completion: completion)
  }
  
}
