//
//  CLLocationProviderType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol LocationManagerProviderType {
  func requestWhenInUseAuthorization(completion: @escaping () -> Void)
  func checkAuthorizationStatusIsNotDetermined() -> Bool
}
