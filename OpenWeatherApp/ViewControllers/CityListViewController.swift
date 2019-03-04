//
//  CityListViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityListViewController: UIViewController {

  private var locationService: LocationManagerServiceType?

  init(locationService: LocationManagerServiceType) {
    super.init(nibName: nil, bundle: nil)
    self.locationService = locationService
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidAppear(_ animated: Bool) {
    if self.isBeingPresented || self.isMovingToParent {
      showLocationSoftAskIfNeeded()
    }
  }

  private func showLocationSoftAskIfNeeded() {
    let isNotDetermined = locationService?.checkAuthorizationStatusIsNotDetermined() ?? false
    if isNotDetermined {
      present(SoftAskViewController(locationService: LocationManagerService()), animated: true)
    }
  }
}
