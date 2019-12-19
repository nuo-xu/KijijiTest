//
//  Client+Ads.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

extension Client {
  /// Return a list of categories
  ///
  /// - parameters: categoryId is the Id of the target category
  /// - note: If this call succeeds,  a list of `Category` will be set to the serialized object
  /// - returns: A `URLSessionTask` if the request starts
  @discardableResult
  func retrieveAdsList(categoryId: Int, _ completion: @escaping RequestCompletion<[Ad]>) -> URLSessionTask? {
    let endpoint = Endpoint<[Ad]>(method: .get, route: "categories/\(categoryId)")
    
    return task(endpoint: endpoint) { result in
      completion(result)
    }
  }
}
