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
  private var cities: [City] = [] {
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
      case .success(let cities):
        cities.forEach { (favoriteCity) in
          self.weatherService?.cityWeather(
            latitude: favoriteCity.lat,
            longitude: favoriteCity.long,
            completion: { (result) in
              switch result {
              case .success(let city):
                DispatchQueue.main.async {
                  self.cities.append(city)
                }
              case .failure(let error):
                print(error)
              }
          })
        }
      default:
        return
      }
    }
  }

  func save(city: City) {
    if let persistence = persistenceService, let name = city.name {
      let context = persistence.getContext()
      let favoriteCity = FavoriteCity(context: context)
      favoriteCity.name = name
      favoriteCity.lat = city.latitude!
      favoriteCity.long = city.longitude!
      do {
        try persistence.saveContext()
        cities.append(city)
      } catch let error {
        print(error)
      }
    }
  }

  private func delete(city: City) {
    if let persistence = persistenceService, let name = city.name {
         let context = persistence.getContext()
         let favoriteCity = FavoriteCity(context: context)
         favoriteCity.name = name
         favoriteCity.lat = city.latitude!
         favoriteCity.long = city.longitude!
      do {
        try persistenceService?.delete(favoriteCity)
      } catch let error {
        print(error)
      }
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
    cell?.city = city

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
    detailViewController.city = city
    navigationController?.pushViewController(detailViewController, animated: true)
  }

  override func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .clear
  }
}
