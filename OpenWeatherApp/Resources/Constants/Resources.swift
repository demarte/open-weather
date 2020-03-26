//
//  Strings.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

struct Resources {

  struct CustomFont {
    static let regular = "Barlow"
    static let bold = "Barlow-Bold"
    static let semiBold = "Barlow-Bold"
  }

  struct AddCityStrings {
    static let navigationTitle = "Type the city name".localized
    static let searchBarPlaceHolder = "Search".localized
    static let cityNotFound = "City not found".localized
  }

  struct SofttAskStrings {
    static let greeting = "Hi".localized
    static let ask = "Can you provide us your location in order to get the current weather?".localized
    static let yesButton = "Yes".localized
    static let maybeButton = "Maybe later".localized
  }

  struct CityListStrings {
    static let emptyStateMessage = "Tap the plus button to add a city".localized
    static let title = "Favorite Cities".localized
    static let cellId = "CityCell"
  }

  struct CityDetailsStrings {
    static let weekdaysLabel = "Today".localized
    static let pressureLabel = "Pressure.".localized + ":"
    static let windLabel = "Wind".localized + ":"
    static let humidityLabel = "Humidity".localized + ":"
  }
}
