//
//  CityListViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityListViewController: UITableViewController {
  // MARK: - Properties
  private var locationService: LocationManagerServiceType?
  private var persistenceService: PersistenceServiceType?
  private var weatherService: WeatherServiceType?
  private let cellId = CityListStrings.cellId
  private var cities: [FavoriteCity] = [] {
    didSet {
      tableView.reloadData()
    }
  }
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
    setUpNavigationItem()
    setUpTableView()
  }

  func setUpNavigationItem() {
    navigationItem.title = CityListStrings.title
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addFavoriteCity))
  }

  func setUpTableView() {
    tableView.register(CityTableViewCell.self, forCellReuseIdentifier: cellId)
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

extension CityListViewController: UISearchBarDelegate {
  // MARK: - TableView Delegate and DataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cities.count == 0 ?
      tableView.setUpTableViewBackground(
        with: CityListStrings.emptyStateMessage,
        header: CityListStrings.title, imageName: "background") : tableView.setUpTableViewBackground(
          with: "",
          header: "", imageName: "background")
    return cities.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CityTableViewCell
    let city = cities[indexPath.row]
    cell?.favoriteCity = city

    return cell!
  }
  // MARK: - TableView EditingStyle
  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let city = cities[indexPath.row]
      delete(city: city)
      cities.remove(at: indexPath.row)
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let service = weatherService else { return }
    let detailViewController = CityDetailViewController(weatherService: service)
    let city = cities[indexPath.row]
    detailViewController.cityName = city.name
    navigationController?.pushViewController(detailViewController, animated: true)
  }

  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .clear
  }
}
