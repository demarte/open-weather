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

  private let imageBackground: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  private let stackView = UIStackView(frame: .zero)

  private let greetingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = SofttAskStrings.greeting
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.bold, size: Sizes.titleFont)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  private let askLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = SofttAskStrings.ask
    label.textColor = Colors.text
    label.font = UIFont(name: CustomFont.regular, size: Sizes.bodyFont)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  private let yesButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(SofttAskStrings.yesButton, for: .normal)
    button.titleLabel?.font = UIFont(name: CustomFont.bold, size: Sizes.bodyFont)
    button.setTitleColor(Colors.text, for: .normal)
    button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
    button.backgroundColor = Colors.secondaryOne
    button.layer.cornerRadius = Sizes.buttonCornerRadius
    return button
  }()

  private let maybeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(SofttAskStrings.maybeButton, for: .normal)
    button.titleLabel?.font = UIFont(name: CustomFont.bold, size: Sizes.bodyFont)
    button.addTarget(self, action: #selector(handleMaybe), for: .touchUpInside)
    button.setTitleColor(Colors.primaryOne, for: .normal)
    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    button.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    button.layer.borderWidth = Sizes.buttonBorderWidth
    button.layer.cornerRadius = Sizes.buttonCornerRadius
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
    view.addSubview(imageBackground)
    view.addSubview(stackView)
  }

  private func setUpStackView() {
    stackView.addArrangedSubview(greetingLabel)
    stackView.addArrangedSubview(askLabel)
    stackView.addArrangedSubview(yesButton)
    stackView.addArrangedSubview(maybeButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    NSLayoutConstraint.activate([
      yesButton.heightAnchor.constraint(equalToConstant: 50),
      maybeButton.heightAnchor.constraint(equalToConstant: 50),
      imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:
        -110)
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
