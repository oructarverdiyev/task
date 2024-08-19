//
//  ConverterCell.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import UIKit.UITableViewCell

final class ConverterCell: UITableViewCell {
  
  var changed: ((Double) -> Void)?
  private var cleared = false
  private let debouncer = Debouncer(delay: 0.5)
  
  private let currencySymbolLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = .white
    label.backgroundColor = .systemGreen
    label.layer.masksToBounds = true
    label.layer.cornerRadius = 8
    label.textAlignment = .center
    return label
  }()
  
  private let currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.textColor = .black.withAlphaComponent(0.7)
    return label
  }()
  
  private let currencyNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .lightGray.withAlphaComponent(0.7)
    return label
  }()
  
  private let currencyTextField: UITextField = {
    let textField = UITextField()
    textField.font = .systemFont(ofSize: 22, weight: .medium)
    textField.textAlignment = .right
    textField.keyboardType = .decimalPad
    
    return textField
  }()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cleared = false
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupView()
    textFieldActions()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    currencySymbolLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
    currencySymbolLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    let labelStack = UIStackView(arrangedSubviews: [currencyCodeLabel, currencyNameLabel],
                                 axis: .vertical,
                                 distribution: .fillProportionally,
                                 alignment: .leading,
                                 spacing: 3)
    
    let labelWithSymbolStack = UIStackView(arrangedSubviews: [currencySymbolLabel, labelStack],
                                           axis: .horizontal,
                                           distribution: .fillProportionally,
                                           alignment: .center,
                                           spacing: 8)
    
    let mainStack = UIStackView(arrangedSubviews: [labelWithSymbolStack, currencyTextField],
                                axis: .horizontal,
                                distribution: .fillEqually)
    
    contentView.appendSubview(mainStack)
    mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
    currencyTextField.delegate = self
  }
  
  private func textFieldActions() {
    currencyTextField.addAction(UIAction { [weak self] _ in
      guard let self = self else { return }
      if !self.cleared {
        self.currencyTextField.text = ""
        self.cleared.toggle()
      }
      
    }, for: .editingDidBegin)
    
    currencyTextField.addAction(UIAction { [weak self] _ in
      self?.currencyTextField.text = self?.currencyTextField.text?.replacingOccurrences(of: ",",
                                                                                        with: ".")
      
      guard let newValueText = self?.currencyTextField.text,
            let newValue = Double(newValueText) else { return }
      
      // combine debounce and sink problems
      self?.debouncer.debounce {
        self?.changed?(newValue)
      }
    }, for: .editingChanged)
  }
  
  func configure(model: ConverterCellViewModel,
                 type: ConverterSegmentType) {
    currencyCodeLabel.text = model.valuteType.rawValue
    currencyNameLabel.text = model.currencyName
    if type == .buy {
      currencyTextField.text = model.buyPrice.description
    } else {
      currencyTextField.text = model.salePrice.description
    }
    currencySymbolLabel.text = model.valuteType.valuteCodeString
  }
}

extension ConverterCell: UITextFieldDelegate {
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String
  ) -> Bool {
    
    textField.text = textField.text?.replacingOccurrences(of: ",",
                                                          with: ".")
    let text = (textField.text ?? "") + string
    guard text.count <= 5 else { return false }
    
    return true
  }
}
