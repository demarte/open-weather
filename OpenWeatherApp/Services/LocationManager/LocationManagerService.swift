//
//  CLLocationManagerService.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct LocationManagerService: LocationManagerServiceType {
  private let locationProvider: LocationManagerProviderType

  init(locationProvider: LocationManagerProviderType = LocationManagerProvider()) {
    self.locationProvider = locationProvider
  }

  func requestWhenInUseAuthorization(completion: @escaping () -> Void) {
    locationProvider.requestWhenInUseAuthorization(completion: completion)
  }
}
