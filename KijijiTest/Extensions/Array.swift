//
//  Array.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

extension Array {

  /// Obtain an item in this array safely if the index is valid
  ///
  /// - parameter index: An index within the array
  /// - returns: An element at the given index, or nil if the index is out of range
  public func at(_ index: Index) -> Element? {
    if index >= 0 && index < count {
      return self[index]
    }
    return nil
  }
}
