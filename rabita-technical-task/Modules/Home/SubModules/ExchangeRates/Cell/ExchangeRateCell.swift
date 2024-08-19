//
//  ExchangeRateCell.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UITableViewCell

final class ExchangeRateCell: UITableViewCell {
  
  private let countryIcon: UIImageView = {
    let image = UIImageView()
    
    return image
  }()
  
  private let currencyNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    
    return label
  }()
  
  private let salePriceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    
    return label
  }()
  
  private let buyPriceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    selectionStyle = .none
    backgroundColor = .white
    
    countryIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
    let countryIconAndLabelStack = UIStackView(arrangedSubviews: [countryIcon, currencyNameLabel],
                                               axis: .horizontal,
                                               distribution: .fillEqually,
                                               spacing: 10)
    
    let mainStack = UIStackView(arrangedSubviews: [countryIconAndLabelStack, salePriceLabel, buyPriceLabel],
                                axis: .horizontal,
                                distribution: .equalCentering)
    
    appendSubview(mainStack)
    mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    mainStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    mainStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
  func configure(with model: ExchangeRateCellViewModel?) {
    guard let model = model else { return }
    countryIcon.image = .init(named: model.valueType.icon)
    currencyNameLabel.text = model.valueType.rawValue
    buyPriceLabel.text = String(model.buyPrice.rounded(toPlaces: 5))
    salePriceLabel.text = String(model.salePrice.rounded(toPlaces: 5))
  }
}

