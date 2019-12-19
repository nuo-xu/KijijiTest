//
//  Endpoint.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-16.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

/// HTTP mothod definitions
enum HTTPMethod: String {
  case get    = "GET"
  case pose   = "POST"
  case put    = "PUT"
  case delete = "DELETE"
}

/// A dictionary http headers to apply to a `URLRequest`
typealias HTTPHeaders = [String: String]

/// Declare a specfic API route that creates a relationshop between that route and a specific type of data if the call is succeeded.
struct Endpoint<T> where T: Decodable {
  /// The HTTP method
  var method: HTTPMethod
  
  /// A specific base URL to use in place of the base URL supplied in `Client.Configuration`
  var baseURL: String?
  
  /// The URL string path defining the route to API function
  var route: String
  
  /// Additonal header to be added for this call
  var headers: HTTPHeaders
  
  init(method: HTTPMethod, route: String, headers: HTTPHeaders? = nil) {
    self.method = method
    self.route = route
    self.headers = headers ?? [:]
  }
}
