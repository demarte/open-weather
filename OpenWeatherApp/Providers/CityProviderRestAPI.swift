//
//  CityProviderRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct CityProviderRestAPI: CityProviderType {
  
  private let apiURL = "https://api.openweathermap.org/data/2.5/weather"
  private let apiKey = "acedb8e3b8769854a49f965fa13752e2"
  
  func fetch(with searchTerm: String, completion: @escaping (City) -> ()) {
    
    guard let url = URL(string: "\(apiURL)?q=\(searchTerm)&APPID=\(apiKey)") else { return }
    
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
      
      guard let data = data else { return }
      
      do {
        let city = try JSONDecoder().decode(City.self, from: data)
        completion(city)
        
      } catch let error {
        print("Error: \(error)")
      }
    }.resume()
  }
  
}
