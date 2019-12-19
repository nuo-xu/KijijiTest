//
//  Ad.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

struct Ad: Codable {
  /// The id of this ad
  let id: Int
  
  /// The title of this ad
  let title: String
  
  /// The price of this ad
  let price: String
  
  /// The image url of this ad
  let imageUrl: String
}
