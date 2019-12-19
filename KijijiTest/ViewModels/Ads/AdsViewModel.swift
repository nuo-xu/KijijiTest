//
//  AdsViewModel.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

protocol AdsViewModelDelegate: class {
  func adsUpdated()
  func fetchingDataStatus(_ isLoading: Bool, error: Error?)
}

class AdsViewModel {
  /// The category name of this ads group
  let categoryName: String
  /// The category id of this ads group
  private let categoryId: Int
  /// A reference of the list of ads
  private (set) var ads = [AdCellViewModel]()
  /// A `AdsViewModelDelegate` for viewmodel to talk to view
  weak var delegate: AdsViewModelDelegate?
  
  init(categoryName: String, categoryId: Int) {
    self.categoryName = categoryName
    self.categoryId = categoryId
  }
  
  /// An API call to retrieve a list of ads
  func fetchAds() {
    // loading
    delegate?.fetchingDataStatus(true, error: nil)
    
    Client.shared.retrieveAdsList(categoryId: categoryId) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .failure(let error):
        self.delegate?.fetchingDataStatus(false, error: error)
      case .success(let ads):
        self.delegate?.fetchingDataStatus(false, error: nil)
        
        self.ads.removeAll()
        for ad in ads {
          let adCellViewModel = AdCellViewModel(imageURL: URL(string: ad.imageUrl), title: ad.title, price: ad.price)
          self.ads.append(adCellViewModel)
        }
        self.delegate?.adsUpdated()
      }
    }
  }
}
