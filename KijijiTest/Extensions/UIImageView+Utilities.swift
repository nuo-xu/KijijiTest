//
//  UIImageView+Utilities.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
  func setImage(with url: URL?) {
    sd_setImage(with: url, placeholderImage: nil, options: [.refreshCached, .retryFailed], context: nil)
  }
}
