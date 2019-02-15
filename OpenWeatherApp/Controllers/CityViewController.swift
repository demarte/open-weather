//
//  CityViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  private let weatherServide: WeatherServiceType = WeatherServiceRestAPI()
  private let searchTerm = "Zihuatanejo"
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherServide.fetch(with: searchTerm) { print($0) }
  }
}
