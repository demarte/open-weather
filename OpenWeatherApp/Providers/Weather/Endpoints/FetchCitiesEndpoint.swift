//
//  FindCityEndpoint.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

enum FetchCitiesEndpoint {
  case citiesBySearchTerm(searchTerm: String)
}

extension FetchCitiesEndpoint: EndpointType {
  var path: String {
    return "find"
  }

  var method: Method {
    return .get
  }

  var parameters: [String: String]? {
    var parameters: [String: String] = ["APPID": Constants.apiKey]
    switch self {
    case .citiesBySearchTerm(let searchTerm):
      parameters["q"] = searchTerm
      return parameters
    }
  }
}
