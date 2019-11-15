//
//  CityListViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityListViewController: UIViewController {
  // MARK: - Constants
  private struct Constants {
    static let emptyStateFontSize: CGFloat = 24.0
    static let emptyStateMessage = "Tap the plus button to add a city".localized
    static let title = "Favorite Cities".localized
  }
  // MARK: - Properties
  private var locationService: LocationManagerServiceType?
  private var persistenceService: PersistenceServiceType?
  private var weatherService: WeatherServiceType?

  private let cellId = "CityCell"
  private var cities: [FavoriteCity] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  private let tableView = UITableView()
  // MARK: - Initializers
  init(locationService: LocationManagerServiceType,
       persistenceService: PersistenceServiceType,
       weatherService: WeatherServiceType) {
    super.init(nibName: nil, bundle: nil)
    self.locationService = locationService
    self.persistenceService = persistenceService
    self.weatherService = weatherService
    finishInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    finishInit()
  }
  // MARK: - View life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchFavoriteCities()
  }

  override func viewDidAppear(_ animated: Bool) {
    if self.isBeingPresented || self.isMovingToParent {
      showLocationSoftAskIfNeeded()
    }
  }

  // MARK: - SetUp View Controller
  func finishInit() {
    setUpView()
    setUpNavigationItem()
    setUpTableView()
  }

  func setUpNavigationItem() {
    navigationItem.title = Constants.title.localized
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addFavoriteCity))
  }

  func setUpView() {
    view.addSubview(tableView)
  }

  func setUpTableView() {
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeHeight = UIScreen.main.bounds.height

    tableView.frame = CGRect(x: 0, y: 0, width: screenSizeWidth, height: screenSizeHeight)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }

  @objc private func addFavoriteCity() {
    if let service = weatherService {
      let addCityViewController = AddCityViewController(weatherService: service, cityListViewController: self)
      let navigationController = UINavigationController(rootViewController: addCityViewController)
      present(navigationController, animated: true, completion: nil)
    }
  }

  // MARK: - Location service methods

  private func showLocationSoftAskIfNeeded() {
    let isNotDetermined = locationService?.checkAuthorizationStatusIsNotDetermined() ?? false
    if isNotDetermined {
      present(SoftAskViewController(locationService: LocationManagerService()), animated: true)
    }
  }

  // MARK: - Persistence service methods
  private func fetchFavoriteCities() {
    if let result = persistenceService?.fetch(FavoriteCity.self) {
      switch result {
      case .success(let value):
        cities = value
      default:
        return
      }
    }
  }

  func save(city: City) {
    if let persistence = persistenceService {
      // 1 - get context
      let context = persistence.getContext()
      // 2 - entity
      let favoriteCity = FavoriteCity(context: context)
      favoriteCity.name = city.name
      favoriteCity.temperature = "\(city.weather.temperature.convertKelvinToCelsius())"
      do {
        try persistence.saveContext()
        fetchFavoriteCities()
      } catch(let error) {
        print(error)
      }
    }
  }

  private func delete(city: FavoriteCity) {
    do {
      try persistenceService?.delete(city)
    } catch(let error) {
      print(error)
    }
  }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
// MARK: - TableView Delegate and DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cities.count == 0 ?
      tableView.setUpEmptyState(with: Constants.emptyStateMessage,
                                ofSize: Constants.emptyStateFontSize) : tableView.restore()
    return cities.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)

    let city = cities[indexPath.row]
    cell.textLabel?.text = city.name
    cell.detailTextLabel?.text = "\(city.temperature)°"

    return cell
  }
  // MARK: - TableView EditingStyle
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let city = cities[indexPath.row]
      delete(city: city)
      cities.remove(at: indexPath.row)
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let service = weatherService else { return }
    let detailViewController = CityDetailViewController(weatherService: service)
    let city = cities[indexPath.row]
    detailViewController.cityName = city.name
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
