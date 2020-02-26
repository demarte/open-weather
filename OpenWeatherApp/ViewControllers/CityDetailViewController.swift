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
  private var weatherService: WeatherServiceType?
  var city: City?
  var forecastWeekly: [City]? {
    willSet {
      let dates = newValue?.map { forecast -> String in
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dateTime ?? 0))
        return weekday(from: date)
      }
      print(dates)
    }
    didSet {
      setUpCity()
    }
  }

  private lazy var cityLabel = createCustomLabel(with: "",
                                                 ofSize: 30.0)
  private lazy var temperatureLabel = createCustomLabel(with: "",
                                                        ofSize: 36.0)
  private lazy var weatherDescriptionLabel = createCustomLabel(with: "",
                                                               ofSize: 20.0)
  private lazy var windDescriptionLabel = createCustomLabel(with: "",
                                                            ofSize: 20.0)
  private lazy var weekdayLabel = createCustomLabel(with: weekday(from: Date()),
                                                    ofSize: 20.0)

  private func weekday(from date: Date) -> String {
    let formatter = DateFormatter()
    return formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date)]
  }

  private func createCustomLabel(with text: String, ofSize fontSize: CGFloat) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont(name: CustomFont.bold, size: fontSize)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }

  private let imageBackground: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "background")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let topViewContainer: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 10
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  private let bottomViewContainer: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - View Life cycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    forecastWeather()
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
    imageBackground.addSubview(topViewContainer)
    imageBackground.addSubview(bottomViewContainer)
    topViewContainer.addArrangedSubview(UIView())
    topViewContainer.addArrangedSubview(cityLabel)
    topViewContainer.addArrangedSubview(temperatureLabel)
    topViewContainer.addArrangedSubview(weatherDescriptionLabel)
    topViewContainer.addArrangedSubview(windDescriptionLabel)
    topViewContainer.addArrangedSubview(weekdayLabel)

    NSLayoutConstraint.activate([
      imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      topViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
      topViewContainer.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
      bottomViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomViewContainer.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
    ])
  }

  private func setUpCity() {
    setUpImageBackGround()
    setUpLabels()
  }

  private func setUpLabels() {
    if let city = self.city, let firstForecast = self.forecastWeekly?.first {
      cityLabel.text = city.name
      temperatureLabel.text = "\(firstForecast.weather.temperature.convertKelvinToCelsius())°"
      weatherDescriptionLabel.text = firstForecast.iconStatus.first?.description
      windDescriptionLabel.text = "wind speed: \(firstForecast.windSpeed)"
    }
  }

  private func setUpImageBackGround() {
    guard let city = self.city else { return }
    if let weatherStatus = city.iconStatus.first {
      imageBackground.image = UIImage(named: "\(weatherStatus.type.lowercased())-background")
    }
  }

  // MARK: - Weather service
  private func forecastWeather() {
    guard let city = self.city else { return }

    if let name = city.name {
      weatherService?.weatherForecast(for: name, completion: { result in
        switch result {
        case .success(let data):
          DispatchQueue.main.async {
            self.forecastWeekly = data.list
          }
        case .failure(let error):
          // TODO: - error handle
          print(error)
        }
      })
    }
  }
}
