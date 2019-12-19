//
//  CategoryCell.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
  
  // MARK: - Design
  
  struct Design {
    static let verticalPadding: CGFloat = 20.0
    static let horizontalPadding: CGFloat = 20.0
    static let labelSpacing: CGFloat = 10.0
  }
  
  // MARK: - Properties
  
  /// A `UILabel` to display category name
  private let nameLabel = UILabel()
  /// A `UILabel` to display ad count
  private let countLabel = UILabel()
  /// The viewmodel
  var viewModel: CategoryCellViewModel? {
    didSet {
      if let viewModel = viewModel {
        nameLabel.text = viewModel.name
        countLabel.text = "Ad Count: \(viewModel.count)"
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setTheme()
    doLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setTheme() {
    nameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
    nameLabel.setContentHuggingPriority(.required, for: .vertical)
    nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    countLabel.font = .systemFont(ofSize: 16.0)
    countLabel.setContentHuggingPriority(.required, for: .vertical)
    countLabel.setContentCompressionResistancePriority(.required, for: .vertical)
  }
  
  private func doLayout() {
    // add nameLabel
    contentView.addSubview(nameLabel)
    
    nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.verticalPadding).isActive = true
    nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Design.horizontalPadding).isActive = true
    nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Design.horizontalPadding).isActive = true
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // add countLabel
    contentView.addSubview(countLabel)
    
    countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Design.labelSpacing).isActive = true
    countLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Design.verticalPadding).isActive = true
    countLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
    countLabel.translatesAutoresizingMaskIntoConstraints = false
  }
}
