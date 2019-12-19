//
//  CategoriesViewModel.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

protocol CategoriesViewModelDelegate: class {
  func categoriesUpdated(_ categories: [CategoryCellViewModel])
  func fetchingDataStatus(_ isLoading: Bool, error: Error?)
}

class CategoriesViewModel {
  /// A reference for the  list of `CategoryViewModel`
  private (set) var categories = [CategoryCellViewModel]()
  /// A `CategoriesViewModelDelegate` for viewmodel to talk to view
  weak var delegate: CategoriesViewModelDelegate?
  
  /// An API call to retrieve a list of categories
  func fetchCategories() {
    // loading
    delegate?.fetchingDataStatus(true, error: nil)
    
    Client.shared.retrieveCategoriesList { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .failure(let error):
        self.delegate?.fetchingDataStatus(false, error: error)
      case .success(var list):
        // sort categories list by ads count (descending)
        list.sort {
          $0.count > $1.count
        }
        
        self.categories.removeAll()
        for category in list {
          let viewModel = CategoryCellViewModel(id: category.id, name: category.name, count: category.count)
          self.categories.append(viewModel)
        }
        
        // finised loading and upate the view
        self.delegate?.fetchingDataStatus(false, error: nil)
        self.delegate?.categoriesUpdated(self.categories)
      }
    }
  }
}
