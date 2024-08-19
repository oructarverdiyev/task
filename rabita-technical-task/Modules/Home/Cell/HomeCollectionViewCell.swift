//
//  HomeCollectionViewCell.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import UIKit.UICollectionViewCell

final class HomeCollectionViewCell: UICollectionViewCell {
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    
    return label
  }()
  
  private let subTitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 14, weight: .medium)
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.backgroundColor = .white
    contentView.clipsToBounds = true
    contentView.addShadow()
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel],
                            axis: .vertical,
                            distribution: .fillProportionally,
                            spacing: 5)
    
    contentView.appendSubview(stack)
    
    stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                   constant: 10).isActive = true
    stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                    constant: -10).isActive = true
  }
  
  func configure(with type: HomeCollectionViewCellType) {
    titleLabel.text = type.title
    subTitleLabel.text = type.subTitle
  }
}
