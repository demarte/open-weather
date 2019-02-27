//
//  CLLocationManagerProvider.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreLocation

typealias DidChangeAuthorizationHandle = () -> Void

class LocationManagerProvider: NSObject, LocationManagerProviderType {
  private var locationManager: CLLocationManager = CLLocationManager()

  private var completion: DidChangeAuthorizationHandle = {}

  override init() {
    super.init()
    locationManager.delegate = self
  }

  func requestWhenInUseAuthorization(completion: @escaping DidChangeAuthorizationHandle) {
    self.completion = completion
    locationManager.requestWhenInUseAuthorization()
  }
}

extension LocationManagerProvider: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    self.completion()
  }
}
