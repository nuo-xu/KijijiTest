//
//  AdCell.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-18.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import UIKit

class AdCell: UITableViewCell {

  // MARK: - Design
  
  struct Design {
    static let verticalPadding: CGFloat = 20.0
    static let labelHorizontalPadding: CGFloat = 10.0
    static let labelSpacing: CGFloat = 10.0
    static let imageWidth: CGFloat = 120.0
  }
  
  // MARK: - Properties
  
  /// A `UILabel` to display ad title
  private let titleLabel = UILabel()
  /// A `UILabel` to display ad price
  private let priceLabel = UILabel()
  /// A `UIImageView` to display ad image
  private let adImageView = UIImageView()
  /// The viewmodel
  var viewModel: AdCellViewModel? {
    didSet {
      if let viewModel = viewModel {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        adImageView.setImage(with: viewModel.imageURL)
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
    titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
    
    priceLabel.font = .systemFont(ofSize: 14.0)
    priceLabel.setContentHuggingPriority(.required, for: .vertical)
    priceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    
    adImageView.contentMode = .scaleAspectFill
    adImageView.clipsToBounds = true
  }
  
  private func doLayout() {
    // add `adImageView`
    contentView.addSubview(adImageView)
    
    adImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    adImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    adImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    adImageView.widthAnchor.constraint(equalToConstant: Design.imageWidth).isActive = true
    adImageView.translatesAutoresizingMaskIntoConstraints = false
    
    // add `titelLabel`
    contentView.addSubview(titleLabel)
    
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.verticalPadding).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: adImageView.rightAnchor, constant: Design.labelHorizontalPadding).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Design.labelHorizontalPadding).isActive = true
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // add `priceLabel`
    contentView.addSubview(priceLabel)
    
    priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Design.labelSpacing).isActive = true
    priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
    priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Design.verticalPadding).isActive = true
    priceLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
  }
}
