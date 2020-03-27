//
//  ErrorMessageView.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/27/20.
//  Copyright © 2020 Ivan De Martino. All rights reserved.
//

import UIKit

final class ErrorMessageView: UIView {
  // MARK: - Properties -
  private let serverMessage: String
  private let errorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Could not connet to server"
    label.font = UIFont(name: Resources.CustomFont.bold, size: Sizes.titleFont)
    label.textColor = Colors.text
    return label
  }()

  private let errorDescription: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Resources.CustomFont.bold, size: Sizes.bodyFont)
    label.textColor = Colors.text
    label.numberOfLines = 0
    return label
  }()

  private let imageBackground: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  // MARK: - Initializers -
  init(frame: CGRect, serverMessage: String) {
    self.serverMessage = serverMessage
    super.init(frame: frame)
    setUpView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  private func setUpView() {
    let inset = CGFloat(10.0)
    self.addSubview(imageBackground)
    self.addSubview(errorLabel)
    self.addSubview(errorDescription)
    self.backgroundColor = Colors.primaryOne
    errorDescription.text = serverMessage
    NSLayoutConstraint.activate([
      imageBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageBackground.topAnchor.constraint(equalTo: topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
      errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      errorDescription.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: inset),
      errorDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 32),
      errorDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      errorDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset)
    ])
  }
}
