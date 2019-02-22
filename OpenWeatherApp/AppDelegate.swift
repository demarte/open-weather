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
  func application(_ _: UIApplication,
                   didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: CityListViewController())
    return true
  }
}
