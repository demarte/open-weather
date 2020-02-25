//
//  AddCityViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 10/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class AddCityViewController: UITableViewController {
  // MARK: - Contants
  private struct Constants {
    static let emptyStateFontSize: CGFloat = 20.0
    static let emptyStateMessage = "City not found".localized
  }
  // MARK: - Properties
  private var weatherService: WeatherServiceType?
  private var cityListViewController: CityListViewController?
  private let cellId = "FetchedCityCell"
  private let debouncer = Debouncer(timeInterval: 0.8)
  private let searchController = UISearchController(searchResultsController: nil)
  private var searchTerm: String?
  private var fetchedCities: [City] = []

  // MARK: - Initializers
  init(weatherService: WeatherServiceType, cityListViewController: CityListViewController) {
    super.init(nibName: nil, bundle: nil)
    self.weatherService = weatherService
    self.cityListViewController = cityListViewController
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
    setUpTableView()
    setUpSearchController()
  }

  private func setUpTableView() {
    tableView.register(AddCityTableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.separatorStyle = .none
    tableView.backgroundColor = .black
    navigationItem.searchController = searchController
    navigationItem.title = AddCityStrings.navigationTitle
  }

  func setUpSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = AddCityStrings.searchBarPlaceHolder
    definesPresentationContext = true
  }
  // MARK: - Service Method
  private func weatherService(searchTerm: String?) {
    guard let searchTerm = searchTerm else { return }
    weatherService?.fetchCities(for: searchTerm, completion: { (result) in
      switch result {
      case .success(let value):
        self.fetchedCities = value.cities
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    })
  }
}

extension AddCityViewController: UISearchResultsUpdating {
  // MARK: - TableView Delegate and DataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedCities.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AddCityTableViewCell
    let city = fetchedCities[indexPath.row]
    cell?.city = city
    return cell!
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let city = fetchedCities[indexPath.row]
    cityListViewController?.save(city: city)
    searchController.dismiss(animated: true, completion: nil)
    self.dismiss(animated: true, completion: nil)
  }
  // MARK: - Search Controller Delegate
  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text {
      if !text.isEmpty {
        searchTerm = text
        debouncer.handler = {
          self.weatherService(searchTerm: self.searchTerm)
        }
        debouncer.renewInterval()
      }
    }
  }
}
