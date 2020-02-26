//
//  UIViewController+Extension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

extension UIViewController {
  func setUpNavigationItemImage() {
    let image = #imageLiteral(resourceName: "logo")
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit

    navigationItem.titleView = imageView
  }
}
