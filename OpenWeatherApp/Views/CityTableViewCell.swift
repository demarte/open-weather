//
//  CityTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/16/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
  // MARK: - Properties -
  static let reuseIdentifier = String(describing: CityTableViewCell.self)
  var city: FavoriteCity? {
    didSet {
      cityLabelName.text = city?.name
    }
  }

  private let cityLabelName: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont(name: Resources.CustomFont.semiBold, size: Sizes.subTitle)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

// MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(cityLabelName)
    setUpContainerStackView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
// MARK: - Set Up Views -
  private func setUpContainerStackView() {

    NSLayoutConstraint.activate([
      cityLabelName.centerYAnchor.constraint(equalTo: centerYAnchor),
      cityLabelName.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      backgroundColor = Colors.primaryOne
    } else {
      backgroundColor = Colors.clear
    }
  }
}
