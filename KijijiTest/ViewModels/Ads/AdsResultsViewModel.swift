//
//  AdsResultsViewModel.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

protocol AdsResultsViewModelDelegate: class {
  func filteredAdsUpdated()
}

struct AdsReultsViewModel {
  /// A reference for the filtered `Ad`s
  var filteredAds = [AdCellViewModel]()
  /// A `CategoriesViewModelDelegate` for viewmodel to talk to view
  weak var delegate: AdsResultsViewModelDelegate?
  
  /// This function will be triggered when search bar text did changed
  mutating func searchBarTextDidChanged(_ text: String) {
    if !text.isEmpty {
      filteredAds = filteredAds.filter({
        $0.title.contains(text)
      })
      
      delegate?.filteredAdsUpdated()
    }
  }
}
