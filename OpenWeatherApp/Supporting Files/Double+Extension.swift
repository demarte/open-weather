//
//  Double+Extension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/17/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

extension Double {

  func convertKelvinToCelsius() -> Double {
    return self - 273.15
  }

  func convertKelvinToFahrenheit() -> Double {
    return (self - 273.15) * 9/5 + 32
  }
}
