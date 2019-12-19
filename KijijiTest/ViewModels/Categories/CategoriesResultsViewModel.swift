//
//  CategoriesResultsViewModel.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

protocol CategoriesResultsViewModelDelegate: class {
  func filteredCategoriesUpdated()
}

struct CategoriesReultsViewModel {
  /// A reference for the filtered `categories`
  var filteredCategories = [CategoryCellViewModel]()
  /// A `CategoriesViewModelDelegate` for viewmodel to talk to view
  weak var delegate: CategoriesResultsViewModelDelegate?
  
  /// This function will be triggered when search bar text did changed
  mutating func searchBarTextDidChanged(_ text: String) {
    if let idInt = Int(text) {
      filteredCategories = filteredCategories.filter ({
        $0.id == idInt
      })
      
      delegate?.filteredCategoriesUpdated()
    }
  }
}
