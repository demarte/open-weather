//
//  UIViewController+Extension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/21/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

// MARK: - Nav Bar Icon -

extension UIViewController {
  func setUpNavigationItemImage() {
    let image = #imageLiteral(resourceName: "logo")
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit

    navigationItem.titleView = imageView
  }
}

// MARK: - Activity Indicator -

private var activityIndicatorView: UIView?

extension UIViewController {
  func showActivityIndicator() {
     activityIndicatorView = UIView(frame: self.view.bounds)
     activityIndicatorView?.backgroundColor = Colors.background
     let activityIndicator = UIActivityIndicatorView(style: .large)
     activityIndicator.color = Colors.text
     activityIndicator.center = activityIndicatorView!.center
     activityIndicator.startAnimating()
     activityIndicatorView?.addSubview(activityIndicator)
     self.view.addSubview(activityIndicatorView!)
   }

   func stopActivityIndicator() {
     activityIndicatorView?.removeFromSuperview()
     activityIndicatorView = nil
   }
}
