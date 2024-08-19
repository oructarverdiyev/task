//
//  ExchangeRatesView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UIView
import Combine

final class ExchangeRatesView: UIView {
  
  let segmentChanged = PassthroughSubject<Int, Never>()
  
  private let segmentController: UISegmentedControl = {
    let segment = UISegmentedControl(items: [ExchangeSegmentType.withoutCash.title,
                                             ExchangeSegmentType.withCash.title])
    segment.backgroundColor = .lightGray.withAlphaComponent(0.3)
    segment.selectedSegmentIndex = 0
    return segment
  }()
  
  private let topStackView: UIStackView = {
    let stack = UIStackView(axis: .vertical,
                            distribution: .fillProportionally,
                            spacing: 4)
    
    return stack
  }()
  
  private let stackBottomLine: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray.withAlphaComponent(0.3)
    view.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
    return view
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.rowHeight = 40
    tableView.showsVerticalScrollIndicator = false
    tableView.register(ExchangeRateCell.self,
                       forCellReuseIdentifier: ExchangeRateCell.reuseId)
    
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
    setupView()
    setupSegments()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .white
    
    appendSubview(segmentController)
    let width = (UIScreen.main.bounds.width / 4) * 3
    segmentController.heightAnchor.constraint(equalToConstant: 35).isActive = true
    segmentController.widthAnchor.constraint(equalToConstant: width).isActive = true
    segmentController.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    segmentController.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    appendSubview(topStackView)
    topStackView.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 10).isActive = true
    topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    
    appendSubview(tableView)
    tableView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10).isActive = true
    tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  private func setupSegments() {
    segmentController.addAction(UIAction { [weak self] _ in
      guard let self = self else { return }
      self.segmentValueChanged(self.segmentController)
    }, for: .valueChanged)
  }
  
  private func setupStackView() {
    let stack = UIStackView(axis: .horizontal,
                            distribution: .equalCentering)
    
    for title in ["Məzənnə", "Alış", "Satış"] {
      let label = UILabel()
      label.textAlignment = .center
      label.text = title
      label.textColor = .lightGray.withAlphaComponent(0.5)
      label.font = .systemFont(ofSize: 12, weight: .medium)
      
      stack.addArrangedSubview(label)
    }
    
    topStackView.addArrangedSubview(stack)
    topStackView.addArrangedSubview(stackBottomLine)
  }
  
  @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
    segmentChanged.send(sender.selectedSegmentIndex)
  }
  
  func getTableView() -> UITableView {
    return tableView
  }
}
