//
//  Client+Categories.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

extension Client {
  /// Return a list of categories
  ///
  /// - note: If this call succeeds,  a list of `Category` will be set to the serialized object
  /// - returns: A `URLSessionTask` if the request starts
  @discardableResult
  func retrieveCategoriesList(_ completion: @escaping RequestCompletion<[Category]>) -> URLSessionTask? {
    let endpoint = Endpoint<[Category]>(method: .get, route: "categories")
    
    return task(endpoint: endpoint) { result in
      completion(result)
    }
  }
}
