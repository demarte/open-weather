//
//  AddCityViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 10/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class AddCityViewController: UITableViewController {
  // MARK: - Properties
  private var weatherService: WeatherServiceType?
  private let cellId = "FetchedCityCell"
  private let debouncer = Debouncer(timeInterval: 0.8)
  private let searchController = UISearchController(searchResultsController: nil)
  private var searchTerm: String?
  private var fetchedCities: [City] = []

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
    setUpSearchController()
  }

  func setUpSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Cities"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  // MARK: - Service Method
  private func weatherService(searchTerm: String?) {
    guard let searchTerm = searchTerm else { return }
    weatherService?.cityWeather(for: searchTerm, completion: { (result) in
      switch result {
      case .success(let value):
        self.fetchedCities.append(value)
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
    let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)

    let city = fetchedCities[indexPath.row]
    cell.textLabel?.text = city.name

    return cell
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
