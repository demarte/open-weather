//
//  AppDelegate.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/7/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ _: UIApplication,
                   didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    let viewController = CityListViewController(locationService: LocationManagerService(),
    persistenceService: PersistenceService(),
    weatherService: WeatherServiceRestAPI())
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.navigationBar.barTintColor = Colors.primaryOne
    navigationController.navigationBar.tintColor = Colors.text

    viewController.setUpNavigationItemImage()
    window?.rootViewController = navigationController
    return true
  }
}
