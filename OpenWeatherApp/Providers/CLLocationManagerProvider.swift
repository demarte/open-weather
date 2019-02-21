//
//  CLLocationManagerProvider.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreLocation

class CLLocationManagerProvider: CLLocationManagerProviderType {
  let locationManager = CLLocationManager()
  func requestWhenInUseAuthorization() {
      locationManager.requestWhenInUseAuthorization()
  }
}
