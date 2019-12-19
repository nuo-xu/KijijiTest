//
//  CategoriesViewController.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-16.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseTableViewController {
  
  // MARK: - Properties
  
  /// A `UISearchController` for users to search categories by category's id
  private lazy var searchController = UISearchController(searchResultsController: resultsController)
  /// A `CategoriesResultsTableController` to display the searched category
  private let resultsController = CategoriesResultsController()
  /// A `CategoriesViewModel` as the viewmodel for `CategoriesViewController`
  private let viewModel = CategoriesViewModel()
  
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTheme()
    registerClasses()
    
    // fetch categories
    viewModel.fetchCategories()
  }
  
  // MARK: - Private func
  
  private func setTheme() {
    title = "Categories"
    view.backgroundColor = .white
    
    navigationController?.view.backgroundColor = .white
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    
    tableView.backgroundColor = .clear
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.placeholder = "Search by category id"
    
    resultsController.tableView.delegate = self
    
    viewModel.delegate = self
  }
  
  private func registerClasses() {
    tableView.register(CategoryCell.self, forCellReuseIdentifier: String(describing: CategoryCell.self))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
  }
}

// MARK: - CategoriesViewModelDelegate

extension CategoriesViewController: CategoriesViewModelDelegate {
  func categoriesUpdated(_ categories: [CategoryCellViewModel]) {
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CategoriesViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.categories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryCell.self), for: indexPath) as? CategoryCell, let categoryViewModel = viewModel.categories.at(indexPath.row) {
      
      cell.viewModel = categoryViewModel
      
      return cell
    }
    
    return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    
    if tableView == self.tableView {
      if let category = viewModel.categories.at(indexPath.row) {
        let adVC = AdsViewController(categoryName: category.name, categoryId: category.id)
        
        navigationController?.pushViewController(adVC, animated: false)
      }
    } else {
      if let category = resultsController.viewModel.filteredCategories.at(indexPath.row) {
        let adVC = AdsViewController(categoryName: category.name, categoryId: category.id)
        
        navigationController?.pushViewController(adVC, animated: false)
      }
    }
  }
}

// MARK: - UISearchResultsUpdating

extension CategoriesViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // reset `filterCategories` once a user enable search
    resultsController.viewModel.filteredCategories = viewModel.categories
    
    if let text = searchController.searchBar.text {
      resultsController.viewModel.searchBarTextDidChanged(text)
    }
  }
}
