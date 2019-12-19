//
//  CategoriesResultsController.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class CategoriesResultsController: UITableViewController {
  
  // MARK: - Properties
  /// A `CategoriesResultsViewModel` as the viewmodel for `CategoriesResultsController`
  var viewModel = CategoriesReultsViewModel()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTheme()
    registerClasses()
  }
  
  // MARK: - Private
  
  private func setTheme() {
    tableView.rowHeight = UITableView.automaticDimension
    
    viewModel.delegate = self
  }
  
  private func registerClasses() {
    tableView.register(CategoryCell.self, forCellReuseIdentifier: String(describing: CategoryCell.self))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
  }
}

// MARK: - Table view data source and Table view delegate
 
extension CategoriesResultsController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.filteredCategories.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryCell.self), for: indexPath) as? CategoryCell, let categoryViewModel = viewModel.filteredCategories.at(indexPath.row) {
      
      cell.viewModel = categoryViewModel
      
      return cell
    }
    
    return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
  }
}

extension CategoriesResultsController: CategoriesResultsViewModelDelegate {
  func filteredCategoriesUpdated() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
}
