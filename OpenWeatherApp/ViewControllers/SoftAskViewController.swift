//
//  SoftAskViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class SoftAskViewController: UIViewController {
  // MARK: - Properties
  private var locationService: LocationManagerServiceType?

  private let stackView = UIStackView(frame: .zero)

  private lazy var greetingLabel = createCustomLabel(with: "Hi".localized,
                                                     ofSize: Constants.titleFont)

  private lazy var askLabel = createCustomLabel(with:
    "Can you provide us your location in order to get the current weather?".localized,
                                                ofSize: Constants.bodyFont)

  private func createCustomLabel(with text: String, ofSize font: CGFloat) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont.systemFont(ofSize: font)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }

  private let yesButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Yes".localized, for: .normal)
    button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
    return button
  }()

  private let maybeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Maybe later".localized, for: .normal)
    button.addTarget(self, action: #selector(handleMaybe), for: .touchUpInside)
    button.setTitleColor(.silver, for: .normal)
    return button
  }()
  // MARK: - Initializers
  init(locationService: LocationManagerServiceType) {
    super.init(nibName: nil, bundle: nil)
    self.locationService = locationService
    finishInit()
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    finishInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    finishInit()
  }

  private func finishInit() {
    setUpView()
    setUpStackView()
  }
  // MARK: - Set up view and subViews
  private func setUpView() {
    view.backgroundColor = .white
    view.layer.borderWidth = Constants.borderWidth
    view.layer.borderColor = UIColor.silver.cgColor
    view.addSubview(stackView)
  }

  private func setUpStackView() {
    stackView.addArrangedSubview(greetingLabel)
    stackView.addArrangedSubview(askLabel)
    stackView.addArrangedSubview(yesButton)
    stackView.addArrangedSubview(maybeButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = Constants.stackViewSpacing
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSpacingToView),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:
        -Constants.stackViewSpacingToView)
      ])
  }
  // MARK: - Functions
  @objc private func handleYes() {
    locationService?.requestWhenInUseAuthorization(completion: {
      self.exit()
    })
  }

  @objc private func handleMaybe() {
    exit()
  }

  private func exit() {
    self.dismiss(animated: true, completion: nil)
  }
}
// MARK: - Constants
extension SoftAskViewController {
  private struct Constants {
    static let borderWidth: CGFloat = 20.0
    static let titleFont: CGFloat = 24.0
    static let bodyFont: CGFloat = 13.0
    static let stackViewSpacingToView: CGFloat = 110.0
    static let stackViewSpacing: CGFloat = 20.0
  }
}
// MARK: - Custom colors
extension UIColor {
  static let silver: UIColor = UIColor(named: "Silver") ?? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
}
