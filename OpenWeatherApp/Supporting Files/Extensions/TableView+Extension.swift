//
//  TableView+Extension.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/16/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

extension UITableView {

  func setUpTableViewBackground(with message: String, header: String, imageName: String) {
    let emptyView = UIView(frame: CGRect(
      x: self.center.x,
      y: self.center.y,
      width: self.bounds.size.width,
      height: self.bounds.size.height))

    let imageBackground = UIImageView(image: UIImage(named: imageName))
    imageBackground.translatesAutoresizingMaskIntoConstraints = false
    imageBackground.contentMode = .scaleToFill

    let stackView = UIStackView()
    let headerLabel = UILabel()
      headerLabel.translatesAutoresizingMaskIntoConstraints = false
      headerLabel.textColor = Colors.text
      headerLabel.textAlignment = .center
      headerLabel.font = UIFont(name: CustomFont.bold, size: Sizes.titleFont)
      headerLabel.text = header

    let messageLabel = UILabel()
      messageLabel.translatesAutoresizingMaskIntoConstraints = false
      messageLabel.textColor = Colors.text
      messageLabel.numberOfLines = 0
      messageLabel.textAlignment = .center
      messageLabel.font = UIFont(name: CustomFont.regular, size: Sizes.bodyFont)
      messageLabel.text = message

    emptyView.addSubview(imageBackground)
    imageBackground.addSubview(stackView)
    stackView.addSubview(headerLabel)
    stackView.addSubview(messageLabel)

    NSLayoutConstraint.activate([
      imageBackground.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
      imageBackground.topAnchor.constraint(equalTo: emptyView.topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor),
      headerLabel.heightAnchor.constraint(equalToConstant: 40.0),
      headerLabel.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
      headerLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor),
      messageLabel.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 100.0),
      messageLabel.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -100.0)
    ])
    self.backgroundView = emptyView
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
