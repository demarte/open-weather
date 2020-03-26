//
//  TemperatureCell.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/26/20.
//  Copyright © 2020 Ivan De Martino. All rights reserved.
//

import UIKit

final class TemperatureCell: UICollectionViewCell {
  // MARK: - Properties -
  static let reusableIdentifier = String(describing: TemperatureCell.self)
  let temperatureLabel = UILabel()
  let timeLabel = UILabel()
  let dateLabel = UILabel()
  let weatherImage = UIImageView()

  // MARK: - Initializers -
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }
  // MARK: - View Set Up -
  private func setUpView() {
    backgroundColor = Colors.clear
    addSubview(dateLabel)
    addSubview(timeLabel)
    addSubview(weatherImage)
    addSubview(temperatureLabel)
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.font = UIFont(name: Resources.CustomFont.regular, size: Sizes.bodyFont)
    timeLabel.textColor = Colors.text
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.font = UIFont(name: Resources.CustomFont.regular, size: Sizes.bodyFont)
    temperatureLabel.textColor = Colors.text
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.font = UIFont(name: Resources.CustomFont.regular, size: Sizes.bodyFont)
    dateLabel.textColor = Colors.text
    weatherImage.translatesAutoresizingMaskIntoConstraints = false
    weatherImage.contentMode = .scaleAspectFit

    setUpConstraints()
  }

  private func setUpConstraints() {
    let inset = CGFloat(10)
    NSLayoutConstraint.activate([
         dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
         dateLabel.heightAnchor.constraint(equalToConstant: 22),
         dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: inset),
         timeLabel.heightAnchor.constraint(equalToConstant: 22),
         timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         weatherImage.widthAnchor.constraint(equalToConstant: 30),
         weatherImage.heightAnchor.constraint(equalToConstant: 30),
         weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
         weatherImage.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: inset),
         temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: inset),
         temperatureLabel.heightAnchor.constraint(equalToConstant: 22),
         temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
       ])
  }
}
