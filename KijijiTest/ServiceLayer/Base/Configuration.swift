//
//  Configuration.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-16.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

/// The available log level for service layer
enum LogLevel {
  // No logs
  case none
  // Simple logging
  case simple
  // Verbose logging
  case verbose
}

/// A set of information for configuring a `Client` instance
struct Configuration {
  /// The base URL to use for all network requests
  var baseURL: String
  
  /// The log level for this client
  var logLevel: LogLevel
  
  init(baseURL: String, logLevel: LogLevel = .none) {
    self.baseURL = baseURL
    self.logLevel = logLevel
  }
}
