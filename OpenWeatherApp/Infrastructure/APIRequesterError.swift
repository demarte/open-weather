//
//  APIRequesterError.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/14/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

enum APIRequesterError: Error {
  case noData
  case invalidResponse
}
