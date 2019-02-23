//
//  CLLocationManagerProvider.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreLocation

struct CLLocationManagerProvider: CLLocationManagerProviderType {
  var isLocationAuthorized: Bool {
    return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
  }

  let locationManager: CLLocationManager = CLLocationManager()

  func requestWhenInUseAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }
}
