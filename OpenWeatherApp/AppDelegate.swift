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
    return true
  }
  private func getInitialViewController() -> UIViewController {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      return SoftAskViewController()
    } else {
      return CityListViewController()
    }
  }
}
