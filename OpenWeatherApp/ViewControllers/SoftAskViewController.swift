//
//  SoftAskViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit
import CoreLocation

class SoftAskViewController: UIViewController, CLLocationManagerDelegate {

  // MARK: Properties
  let locationManager = CLLocationManager()
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
  private let askTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    textView.isEditable = false
    let headerAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
    let bodyTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
    let text = NSMutableAttributedString(string: "Hi", attributes: headerAttributes)
    text
      .append(
        NSMutableAttributedString(string: "\n\nCan you provide us your location in order to get the current weather?",
          attributes: bodyTextAttributes))
    textView.attributedText = text
    textView.textAlignment = .center
    return textView
  }()
  private let yesButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Yes", for: .normal)
    button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
    return button
  }()
  private let maybeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Maybe later", for: .normal)
    button.addTarget(self, action: #selector(handleMaybe), for: .touchUpInside)
    button.setTitleColor(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), for: .normal)
    return button
  }()
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  // MARK: Initializers
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
    setupTopView()
    setupAskTextView()
    setupBottomStackView()
  }
  // MARK: Setup view and subViews
  private func setupView() {
    view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
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
  private func setupTopView() {
    containerView.addSubview(topContainerView)
    NSLayoutConstraint.activate([
      topContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
      topContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      topContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
      ])
  }
  private func setupAskTextView() {
    topContainerView.addSubview(askTextView)
    NSLayoutConstraint.activate([
      askTextView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
      askTextView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 100),
      askTextView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -100),
      askTextView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5)
      ])
  }
  private func setupBottomStackView() {
    let bottomStackView = UIStackView(arrangedSubviews: [yesButton, maybeButton])
    bottomStackView.distribution = .fillEqually
    bottomStackView.axis = .vertical
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(bottomStackView)
    NSLayoutConstraint.activate([
      bottomStackView.heightAnchor.constraint(equalToConstant: 100),
      bottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      bottomStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      bottomStackView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor)
      ])
  }
  // MARK: buttons handle actions
  @objc private func handleYes() {
    checkLocationServices()
    // TODO: go to CityListViewController
  }
  @objc private func handleMaybe() {
    // TODO: go to CityListViewController
  }
  // MARK: location functions
  private func checkLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
      setupLocationManager()
      checkLocationAuthorization()
    } else {
      let alert = UIAlertController(title: "Location Services disabled",
                                    message: "Please enable Location Services in Settings",
                                    preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      present(alert, animated: true, completion: nil)
    }
  }
  private func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  private func checkLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      break
    case .authorizedAlways:
      break
    case .denied:
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      break
    }
  }

}