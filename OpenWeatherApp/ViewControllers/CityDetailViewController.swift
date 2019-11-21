//
//  CityDetailViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityDetailViewController: UIViewController {

  // MARK: - Properties
  private lazy var cityLabel = createCustomLabel(with:
    "teste".localized,
                                                 ofSize: 18.0)

  private func createCustomLabel(with text: String, ofSize font: CGFloat) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont.systemFont(ofSize: font)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }

  private let imageBackground: UIImageView = {
    let image = UIImageView(image: UIImage(named: "clouds-background"))
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private var weatherService: WeatherServiceType?
  var cityName: String?

  // MARK: - View Life cycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    weather()
  }

  // MARK: - Initializers
  init(weatherService: WeatherServiceType) {
    super.init(nibName: nil, bundle: nil)
    self.weatherService = weatherService
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
  }
  // MARK: - Set up view and subViews
  private func setUpView() {
    view.addSubview(imageBackground)
    view.addSubview(cityLabel)

    NSLayoutConstraint.activate([
      imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  // MARK: - Service Method
  private func weather() {
    guard let city = cityName else { return }
    weatherService?.cityWeather(for: city, completion: { (result) in
      switch result {
      case .success(let city):
        DispatchQueue.main.async {
          print(city)
        }
      case .failure(let error):
        print(error)
      }
    })
  }
}
