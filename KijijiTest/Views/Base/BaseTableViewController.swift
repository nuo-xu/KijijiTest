//
//  BaseTableViewController.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
  
  // MARK: - Design
   
  struct Design {
    static let spinnerSize = CGSize(width: 20.0, height: 20.0)
    static let spinnerColor = UIColor.gray
    static let spinnerTopPadding: CGFloat = 20.0
  }
  
  // MARK: - Properties
  
  /// A `UIActivityIndicatorView` that will be displayed for loading state
  let spinner = UIActivityIndicatorView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTheme()
    doLayout()
  }
  
  // MARK: - Private
  
  private func setTheme() {
    spinner.tintColor = Design.spinnerColor
    spinner.isHidden = true
  }
  
  private func doLayout() {
    view.addSubview(spinner)
       
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.topAnchor.constraint(equalTo: view.topAnchor, constant: Design.spinnerTopPadding).isActive = true
    spinner.widthAnchor.constraint(equalToConstant: Design.spinnerSize.width).isActive = true
    spinner.heightAnchor.constraint(equalToConstant: Design.spinnerSize.height).isActive = true
    spinner.translatesAutoresizingMaskIntoConstraints = false
  }
}
