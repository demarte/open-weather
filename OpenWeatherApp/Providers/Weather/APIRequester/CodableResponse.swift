//
//  CodableResponses.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/26/20.
//  Copyright © 2020 Ivan De Martino. All rights reserved.
//

import Foundation

struct OpenWeatherResponse<T: Decodable>: Decodable {
  let list: [T]
}
