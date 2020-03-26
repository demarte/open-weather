//
//  CityDetailViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/15/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

// TODO: - fix layout
final class CityDetailViewController: UIViewController {
  // MARK: - Properties -
  private var weatherService: WeatherServiceType?
  let favoriteCity: FavoriteCity
  var city: City?
  var forecastWeekly: [City]? {
    didSet {
      setUpCity()
    }
  }
  private var dataSource: UICollectionViewDiffableDataSource<Section, City>!
  private var collectionView: UICollectionView!
  private lazy var cityLabel = createCustomLabel(with: "",
                                                 ofSize: 34.0)
  private lazy var temperatureLabel = createCustomLabel(with: "",
                                                        ofSize: 40.0)
  private lazy var weatherDescriptionLabel = createCustomLabel(with: "",
                                                               ofSize: 20.0)
  private lazy var windDescriptionLabel = createCustomLabel(with: "",
                                                            ofSize: 20.0)
  private lazy var weekdayLabel = createCustomLabel(with: weekday(from: Date()),
                                                    ofSize: 20.0)
  private lazy var maxTemperatureLabel = createCustomLabel(with: "", ofSize: 20.0)
  private lazy var minTemperatureLabel = createCustomLabel(with: "", ofSize: 20.0)
  private lazy var pressureLabel = createCustomLabel(with: "", ofSize: 20.0)
  private lazy var humidityLabel = createCustomLabel(with: "", ofSize: 20.0)

  private func weekday(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return "\(formatter.string(from: Date())) \(Resources.CityDetailsStrings.weekdaysLabel)"
  }

  private func createCustomLabel(with text: String, ofSize fontSize: CGFloat) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.textColor = Colors.text
    label.font = UIFont(name: Resources.CustomFont.bold, size: fontSize)
    label.textAlignment = .center
    return label
  }

  private let imageBackground: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "background")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // MARK: - Initializers -
  init(weatherService: WeatherServiceType, favoriteCity: FavoriteCity) {
    self.weatherService = weatherService
    self.favoriteCity = favoriteCity
    super.init(nibName: nil, bundle: nil)
    self.finishInit()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func finishInit() {
    setUpCollectionView()
    setUpView()
    self.showActivityIndicator()
    cityWeather()
  }
  // MARK: - Set up view and subViews -
  private func setUpView() {
    view.addSubview(imageBackground)
    view.addSubview(cityLabel)
    view.addSubview(weatherDescriptionLabel)
    view.addSubview(temperatureLabel)
    view.addSubview(maxTemperatureLabel)
    view.addSubview(minTemperatureLabel)
    view.addSubview(weekdayLabel)
    view.addSubview(collectionView)
    view.addSubview(pressureLabel)
    view.addSubview(humidityLabel)
    view.addSubview(windDescriptionLabel)
    setUpConstraints()
  }

  private func setUpCity() {
    setUpImageBackGround()
    setUpLabels()
    configureSnapShot()
  }

  private func setUpLabels() {
    if let firstForecast = self.forecastWeekly?.first {
      cityLabel.text = city?.name
      temperatureLabel.text = "\(firstForecast.weather.temperature.convertKelvinToCelsius())°"
      weatherDescriptionLabel.text = firstForecast.iconStatus.first?.description
      windDescriptionLabel.text = "\(Resources.CityDetailsStrings.windLabel) \(firstForecast.windSpeed) m/s"
      maxTemperatureLabel.text = "\(city?.weather.maximumTemperature.convertKelvinToCelsius() ?? 0)°"
      minTemperatureLabel.text = "\(city?.weather.minimumTemperature.convertKelvinToCelsius() ?? 0)°"
      pressureLabel.text = "\(Resources.CityDetailsStrings.pressureLabel) \(city?.weather.pressure ?? 0) hpa"
      humidityLabel.text = "\(Resources.CityDetailsStrings.humidityLabel) \(city?.weather.humidity ?? 0) %"
    }
  }

  private func setUpImageBackGround() {
    if let weatherStatus = city?.iconStatus.first {
      imageBackground.image = UIImage(named: "\(weatherStatus.type.lowercased())-background")
    }
  }

  // MARK: - Weather service -
  private func cityWeather() {
    weatherService?.cityWeather(latitude: favoriteCity.lat, longitude: favoriteCity.long, completion: { result in
      switch result {
      case .success(let city):
        self.city = city
        self.forecastWeather { result in

          switch result {
          case .success(let data):
            DispatchQueue.main.async {
              self.forecastWeekly = data.list
              self.stopActivityIndicator()
            }
          case .failure(let error):
            // TODO: error handle
            print(error)
          }
        }
      case .failure(let error):
        print(error)
      }
    })

  }
  private func forecastWeather(completion: @escaping (Result<OpenWeatherResponse<City>>) -> Void) {
    weatherService?.weatherForecast(for: favoriteCity.name, completion: completion)
  }
}

// MARK: - Collection View Layout -

extension CityDetailViewController {
  private func setUpCollectionView() {
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: configureCollectionView())
    collectionView.backgroundColor = Colors.clear
    collectionView.layer.borderWidth = 1.0
    collectionView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(TemperatureCell.self, forCellWithReuseIdentifier: TemperatureCell.reusableIdentifier)
    configureDataSource()
  }

  private func configureCollectionView() -> UICollectionViewCompositionalLayout {
    let sectionProvider = {
      (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0))

      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .absolute(200),
        heightDimension: .absolute(300))

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      section.contentInsets = NSDirectionalEdgeInsets(
        top: 10,
        leading: 10,
        bottom: 10,
        trailing: 10
      )
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
}

// MARK: - Diffable Data Source -

extension CityDetailViewController {
  typealias TemperatureDataSource = UICollectionViewDiffableDataSource<Section, City>

  enum Section {
    case main
  }

  private func configureDataSource() {
    dataSource = TemperatureDataSource(
    collectionView: collectionView) { (collectionView, indexPath, city) -> UICollectionViewCell? in

      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TemperatureCell.reusableIdentifier, for: indexPath) as? TemperatureCell else { return nil }
      cell.timeLabel.text = city.time
      cell.temperatureLabel.text = "\(city.weather.temperature.convertKelvinToCelsius())°"
      cell.dateLabel.text = city.date
      cell.weatherImage.image = UIImage(named: city.iconStatus.first?.path ?? "logo")
      return cell
    }
  }

  private func configureSnapShot() {
    guard let forecast = self.forecastWeekly else { return }
    var currentSnapshot = NSDiffableDataSourceSnapshot<Section, City>()
    currentSnapshot.appendSections([.main])
    currentSnapshot.appendItems(forecast)
    dataSource.apply(currentSnapshot, animatingDifferences: false)
  }
}

// MARK: - Constraints -

extension CityDetailViewController {
  private func setUpConstraints() {
    let inset = CGFloat(20)
    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
      imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      cityLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: inset),
      cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cityLabel.heightAnchor.constraint(equalToConstant: 32),
      weatherDescriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
      weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 32),
      temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor),
      temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      temperatureLabel.heightAnchor.constraint(equalToConstant: 50),
      weekdayLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      weekdayLabel.heightAnchor.constraint(equalToConstant: 32),
      weekdayLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: inset),
      minTemperatureLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -inset),
      minTemperatureLabel.heightAnchor.constraint(equalToConstant: 32),
      minTemperatureLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: inset),
      maxTemperatureLabel.trailingAnchor.constraint(equalTo: minTemperatureLabel.leadingAnchor, constant: -inset),
      maxTemperatureLabel.heightAnchor.constraint(equalToConstant: 32),
      maxTemperatureLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: inset),
      collectionView.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: inset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 320),
      pressureLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      pressureLabel.heightAnchor.constraint(equalToConstant: 32),
      pressureLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: inset),
      humidityLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      humidityLabel.heightAnchor.constraint(equalToConstant: 32),
      humidityLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: inset),
      windDescriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      windDescriptionLabel.heightAnchor.constraint(equalToConstant: 32),
      windDescriptionLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: inset)
    ])
  }
}
