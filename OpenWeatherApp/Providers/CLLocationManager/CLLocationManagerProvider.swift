//
//  CLLocationManagerProvider.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreLocation

class CLLocationManagerProvider: NSObject, CLLocationManagerProviderType {
  var locationManager: CLLocationManager = CLLocationManager()

  var completion: (() -> Void) = {}

  override init() {
    super.init()
    locationManager.delegate = self
  }

  func requestWhenInUseAuthorization(completion: @escaping () -> Void) {
    self.completion = completion
    locationManager.requestWhenInUseAuthorization()
  }
}

extension CLLocationManagerProvider: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    self.completion()
  }
}
