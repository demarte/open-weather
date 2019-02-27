//
//  CityListViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit
import CoreLocation

final class CityListViewController: UIViewController {
  override func viewDidAppear(_ animated: Bool) {
    if self.isBeingPresented || self.isMovingToParent {
      showLocationSoftAskIfNeeded()
    }
  }

  private func showLocationSoftAskIfNeeded() {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      present(SoftAskViewController(locationService: LocationManagerService()), animated: true)
    }
  }
}
