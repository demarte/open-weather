//
//  AddCityViewController.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 10/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import UIKit

final class AddCityViewController: UITableViewController {
  // MARK: - Contants -
  private struct Constants {
    static let emptyStateFontSize: CGFloat = 20.0
    static let emptyStateMessage = Resources.AddCityStrings.cityNotFound
  }
  // MARK: - Properties -
  private var weatherService: WeatherServiceType?
  private var cityListViewController: CityListViewController?
  private let debouncer = Debouncer(timeInterval: 0.8)
  private let searchController = UISearchController(searchResultsController: nil)
  private var searchTerm: String?
  private var fetchedCities: [City] = []

  // MARK: - View Life Cycle -
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    DispatchQueue.main.async {
      self.searchController.searchBar.searchTextField.becomeFirstResponder()
    }
  }

  // MARK: - Initializers -
  init(weatherService: WeatherServiceType, cityListViewController: CityListViewController) {
    super.init(nibName: nil, bundle: nil)
    self.weatherService = weatherService
    self.cityListViewController = cityListViewController
    finishInit()
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    fatalError("init(coder:) has not been implemented")
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func finishInit() {
    setUpSearchController()
    setUpTableView()
  }
  // MARK: - Set up View -
  private func setUpTableView() {
    tableView.backgroundColor = Colors.transparent
    tableView.register(AddCityTableViewCell.self, forCellReuseIdentifier: AddCityTableViewCell.reuseIdentifier)
    tableView.separatorStyle = .none
  }

  func setUpSearchController() {
    navigationController?.navigationBar.barTintColor = Colors.secondaryOne
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = Resources.AddCityStrings.searchBarPlaceHolder
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = true
  }
  // MARK: - Service Method -
  private func weatherService(searchTerm: String?) {
    guard let searchTerm = searchTerm else { return }
    weatherService?.fetchCities(for: searchTerm, completion: { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          if data.list.count > 0 {
            self?.fetchedCities = data.list
            self?.tableView.reloadData()
          } else {
            self?.tableView.setUpTableViewBackground(
              with: "",
              header: Resources.AddCityStrings.cityNotFound,
              imageName: "background")
          }
        }
      case .failure(let error):
        self?.showError(serverMessage: error.localizedDescription)
      }
    })
  }

  // MARK: - Error Handle -

  private func showError(serverMessage: String) {
    DispatchQueue.main.async {
      self.stopActivityIndicator()
      self.showErrorMessage(serverMessage: serverMessage)
    }
  }

  // MARK: - Dimiss View Controller -
  private func dimissViewController() {
    DispatchQueue.main.async {
      self.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
}

// MARK: - TableView Delegate and DataSource -
extension AddCityViewController {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    tableView.setUpTableViewBackground(with: "", header: "", imageName: "background")
    return fetchedCities.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: AddCityTableViewCell.reuseIdentifier, for: indexPath) as? AddCityTableViewCell
    let city = fetchedCities[indexPath.row]
    cell?.city = city
    return cell!
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let city = fetchedCities[indexPath.row]
    cityListViewController?.save(city: city)
    dimissViewController()
  }
}

// MARK: - Search Controller Delegate -

extension AddCityViewController: UISearchResultsUpdating {
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

// MARK: - Search Bar Delegate -

extension AddCityViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    dimissViewController()
  }
}
