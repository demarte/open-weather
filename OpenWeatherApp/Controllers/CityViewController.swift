//
//  CityViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/12/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  
  private let cityService: CityServiceType = CityServiceRestAPI()
  private let searchTerm = "Zihuatanejo"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cityService.fetch(with: searchTerm) { print($0) }
  }
  
}
