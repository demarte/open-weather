//
//  AppDelegate.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/7/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: CityListViewController())
    window?.makeKeyAndVisible()
    showLocationSoftAskIfNeeded()
    return true
  }
  private func showLocationSoftAskIfNeeded() {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      window?.rootViewController?.present(SoftAskViewController(), animated: true)
    }
  }
}
