//
//  SoftAskViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit
import CoreLocation

final class SoftAskViewController: UIViewController, CLLocationManagerDelegate {
  // MARK: Properties
  var locationService: CLLocationManagerServiceType?
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  private let topContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let stackView = UIStackView(frame: .zero)
  private lazy var greetingLabel = createCustomLabel(with: "Hi".localized, ofSize: 24)
  private lazy var askLabel = createCustomLabel(with:
    "Can you provide us your location in order to get the current weather?".localized,
                                                ofSize: 13)
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
    button.setTitleColor(UIColor(named: "Silver"), for: .normal)
    return button
  }()
  // MARK: Initializers
  init(locationService: CLLocationManagerServiceType) {
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
    setupView()
    setupContainerView()
    setupStackView()
  }
  // MARK: Setup view and subViews
  private func setupView() {
    view.backgroundColor = UIColor(named: "Silver")
  }
  private func setupContainerView() {
    view.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
      ])
  }
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.addArrangedSubview(greetingLabel)
    stackView.addArrangedSubview(askLabel)
    stackView.addArrangedSubview(yesButton)
    stackView.addArrangedSubview(maybeButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 110),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -110)
      ])
  }
  // MARK: buttons handle actions
  @objc private func handleYes() {
    locationService?.requestWhenInUseAuthorization()
    // TODO: go to CityListViewController
  }
  @objc private func handleMaybe() {
    // TODO: go to CityListViewController
  }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
