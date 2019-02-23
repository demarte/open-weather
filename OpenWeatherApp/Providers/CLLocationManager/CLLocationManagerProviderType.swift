//
//  CLLocationProviderType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol CLLocationManagerProviderType {
  var isLocationAuthorized: Bool { get }

  func requestWhenInUseAuthorization()
}
