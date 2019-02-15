//
//  CityProviderRestAPI.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct CityProviderRestAPI: CityProviderType {
  let api = "https://api.openweathermap.org/data/2.5/weather"
  func cityWeather(for searchTerm: String, completion: @escaping (City) -> Void) {
    guard let url = URL(string: "\(api)?q=\(searchTerm)&APPID=\(Constants.apiKey)")
      else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, _, error) in
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
