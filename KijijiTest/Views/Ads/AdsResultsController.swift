//
//  AdsResultsController.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class AdsResultsController: UITableViewController {
  
  // MARK: - Design
  
  struct Design {
    static let rowHeight: CGFloat = 120.0
  }

  // MARK: - Properties
  /// A `AdsResultsViewModel` as the viewmodel for `AdsResultsController`
  var viewModel = AdsReultsViewModel()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTheme()
    registerClasses()
  }
  
  // MARK: - Private
  
  private func setTheme() {
    tableView.rowHeight = Design.rowHeight
    
    viewModel.delegate = self
  }
  
  private func registerClasses() {
    tableView.register(AdCell.self, forCellReuseIdentifier: String(describing: AdCell.self))
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
  }
}

// MARK: - Table view data source

extension AdsResultsController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.filteredAds.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdCell.self), for: indexPath) as? AdCell, let adViewModel = viewModel.filteredAds.at(indexPath.row) {
      
      cell.viewModel = adViewModel
      cell.selectionStyle = .none
      
      return cell
    }
    
    return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
  }
}

// MARK: -

extension AdsResultsController: AdsResultsViewModelDelegate {
  
  func filteredAdsUpdated() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
}
