//
//  SoftAskViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class SoftAskViewController: UIViewController {
  // MARK: Properties
  var locationService: LocationManagerServiceType?

  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
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
    button.setTitleColor(.silver, for: .normal)
    return button
  }()
  // MARK: Initializers
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
    setUpContainerView()
    setUpStackView()
  }
  // MARK: Setup view and subViews
  private func setUpView() {
    view.backgroundColor = .silver
  }

  private func setUpContainerView() {
    view.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
      ])
  }

  private func setUpStackView() {
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
  // MARK: functions
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

extension UIColor {
  static let silver: UIColor = UIColor(named: "Silver") ?? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
}
