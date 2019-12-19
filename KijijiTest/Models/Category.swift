//
//  Category.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

struct Category: Codable {
  /// The id of this category
  let id: Int
  
  /// The name of this category
  let name: String
  
  /// The ad count of this category
  let count: Int
}
