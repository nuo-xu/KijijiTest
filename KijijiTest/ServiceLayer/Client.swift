//
//  Client.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-16.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

class Client {
  /// Singletion Instance that can be accessed globally
  static let shared = Client()
  
  /// Configuration for the `Client`
  var configuration: Configuration?
}
