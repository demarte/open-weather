//
//  CLLocationManagerService.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct CLLocationManagerService: CLLocationManagerServiceType {
  private let locationProvider: CLLocationManagerProviderType

  var isLocationAuthorized: Bool {
    return locationProvider.isLocationAuthorized
  }

  init(locationProvider: CLLocationManagerProviderType = CLLocationManagerProvider()) {
    self.locationProvider = locationProvider
  }

  func requestWhenInUseAuthorization() {
    locationProvider.requestWhenInUseAuthorization()
  }
}
