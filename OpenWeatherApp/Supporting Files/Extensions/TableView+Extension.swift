//
//  TableView+Extension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/16/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

extension UITableView {

  func setUpEmptyState(with message: String, ofSize font: CGFloat) {

    let emptyView = UIView(frame: CGRect(
      x: self.center.x,
      y: self.center.y,
      width: self.bounds.size.width,
      height: self.bounds.size.height))

    let messageLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      label.numberOfLines = 0
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: font)
      label.text = message.localized
      return label
    }()

    emptyView.addSubview(messageLabel)

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 100.0),
      messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -100.0)
    ])

    self.backgroundView = emptyView
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
