//
//  AdsViewController.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class AdsViewController: BaseTableViewController {
  
  // MARK: - Design
  
  struct Design {
    static let rowHeight: CGFloat = 120.0
  }
  
  // MARK: - Properties
  
  /// A `UISearchController` for users to search categories by category's id
  private lazy var searchController = UISearchController(searchResultsController: resultsController)
  /// A `CategoriesResultsTableController` to display the searched category
  private let resultsController = AdsResultsController()
  /// A `AdsViewModel` as the viewmodel for `AdsViewController`
  private var viewModel: AdsViewModel
  
  init(categoryName: String, categoryId: Int) {
    self.viewModel = AdsViewModel(categoryName: categoryName, categoryId: categoryId)
    super.init(style: .plain)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTheme()
    registerClasses()
    
    // fetch ads
    viewModel.fetchAds()
  }
  
  // MARK: Private func
  
  private func setTheme() {
    title = "\(viewModel.categoryName) Ads"
    view.backgroundColor = .white
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    
    tableView.backgroundColor = .clear
    tableView.tableFooterView = UIView()
    tableView.rowHeight = Design.rowHeight
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.placeholder = "Search by ad title"
    
    viewModel.delegate = self
  }
  
  private func registerClasses() {
    tableView.register(AdCell.self, forCellReuseIdentifier: String(describing: AdCell.self))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
  }
}

// MARK: - Table view data source

extension AdsViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.ads.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdCell.self), for: indexPath) as? AdCell, let adViewModel = viewModel.ads.at(indexPath.row) {
      
      cell.viewModel = adViewModel
      
      return cell
    }
    
    return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
  }
}

// MARK: - AdsViewModelDelegate

extension AdsViewController: AdsViewModelDelegate {
  func adsUpdated() {
    tableView.reloadData()
  }
  
  func fetchingDataStatus(_ isLoading: Bool, error: Error?) {
    if isLoading {
      spinner.startAnimating()
    } else {
      spinner.stopAnimating()
    }
    spinner.isHidden = !isLoading
    view.isUserInteractionEnabled = !isLoading
    
    if let error = error {
      let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      
      present(alertController, animated: true, completion: nil)
    }
  }
}

// MARK: - UISearchResultsUpdating

extension AdsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // reset `filterAds` once a user enable search
    resultsController.viewModel.filteredAds = viewModel.ads

    if let text = searchController.searchBar.text {
      resultsController.viewModel.searchBarTextDidChanged(text)
    }
  }
}
