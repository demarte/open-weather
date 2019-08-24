//
//  CityListViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/19/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class CityListViewController: UIViewController {
  // MARK: - Properties

  private var locationService: LocationManagerServiceType?
  private var persistenceService: PersistenceServiceType?

  private let cellId = "CityCell"
  private var cities: [FavoriteCity] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  private let tableView = UITableView()

  // MARK: - Init

  init(locationService: LocationManagerServiceType, persistenceService: PersistenceServiceType) {
    super.init(nibName: nil, bundle: nil)
    self.locationService = locationService
    self.persistenceService = persistenceService

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

  // MARK: - Location service methods

  private func showLocationSoftAskIfNeeded() {
    let isNotDetermined = locationService?.checkAuthorizationStatusIsNotDetermined() ?? false
    if isNotDetermined {
      present(SoftAskViewController(locationService: LocationManagerService()), animated: true)
    }
  }

  // MARK: - Persistence service methods

  @objc private func addFavoriteCity() {
//    let context = persistenceService?.getContext()
//    favoriteCity = FavoriteCity(context: context)
//    favoriteCity?.name = "New York"
//    favoriteCity?.temperature = "14"
//    if let city = favoriteCity {
//       cities.append(city)
//    }
  }

  private func fetchFavoriteCities() {
    if let result = persistenceService?.fetch(FavoriteCity.self) {
      switch result {
      case .success(let value):
        value.forEach { city in
          cities.append(city)
        }
      default:
        print("nothing")
      }
    }
  }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {

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
      cities.remove(at: indexPath.row)
    }
  }

  // MARK: - Constants

  private struct Constants {
    static let emptyStateFontSize: CGFloat = 24.0
    static let emptyStateMessage = "Tap the plus to add a city"
    static let title = "Favorite Cities"
  }
}
