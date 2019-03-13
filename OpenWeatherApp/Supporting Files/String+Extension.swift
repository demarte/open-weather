//
//  StringExtension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/27/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
