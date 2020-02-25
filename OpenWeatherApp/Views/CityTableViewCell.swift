//
//  CityTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/16/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {

  enum Degree: String {
    case fahrenheit = "F"
    case celsius = "C"
  }

  // MARK: - Properties
  var city: City? {
    didSet {
      cityLabelName.text = "\(city?.name ?? "")"
      temperatureLabel.text = "\(city?.weather.temperature ?? 0)\(labelDegree.rawValue)°"
    }
  }
  private var labelDegree: Degree = .fahrenheit
  private let containerStackView = UIStackView()
  private let cityNameStackView = UIStackView()

  private let cityLabelName: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.semiBold, size: Sizes.subTitle)
    label.textAlignment = .left
    return label
  }()

  private let countryLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.regular, size: Sizes.bodyFont)
    label.textAlignment = .left
    return label
  }()

  private let descriptionWeatherLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.regular, size: Sizes.bodyFont)
    label.textAlignment = .left
    return label
  }()

  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.regular, size: Sizes.bodyFont)
    label.textAlignment = .left
    return label
  }()
// MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(containerStackView)
    setUpContainerStackView()
    setUpCityNameStackView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
// MARK: - Set Up Views
  private func setUpContainerStackView() {
    containerStackView.axis = .horizontal
    containerStackView.spacing = 5
    containerStackView.addArrangedSubview(cityNameStackView)
    containerStackView.addArrangedSubview(temperatureLabel)
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
      containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
    ])
  }

  private func setUpCityNameStackView() {
    cityNameStackView.distribution = .equalSpacing
    cityNameStackView.axis = .horizontal
    cityNameStackView.spacing = 5
    cityNameStackView.addArrangedSubview(cityLabelName)
    cityNameStackView.addArrangedSubview(descriptionWeatherLabel)
    cityNameStackView.addArrangedSubview(countryLabel)
    cityNameStackView.translatesAutoresizingMaskIntoConstraints = false
  }
}
