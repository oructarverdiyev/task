//
//  ConverterView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import UIKit.UIView
import Combine

final class ConverterView: UIView {
  let segmentChanged = PassthroughSubject<Int, Never>()
  let dismiss = PassthroughSubject<Void, Never>()
  var cancellables = Set<AnyCancellable>()
  
  private let topView: ViewControllerTopView = {
    let view = ViewControllerTopView()
    
    return view
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 60
    tableView.showsVerticalScrollIndicator = false
    tableView.register(ConverterCell.self,
                       forCellReuseIdentifier: ConverterCell.reuseId)
    
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSegments()
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   func setupView() {
    backgroundColor = .white
    
    appendSubview(topView)
    appendSubview(tableView)
    
    topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    topView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
    tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  func setupSegments() {
    topView.insertSegments(segments: [ConverterSegmentType.buy,
                                      ConverterSegmentType.sale])
    topView.segmentChanged
      .sink { [weak self] value in
        self?.segmentChanged.send(value)
      }.store(in: &cancellables)
    
    topView.dismiss
      .sink { [weak self] in
        self?.dismiss.send()
      }.store(in: &cancellables)
  }
  
  func getTableView() -> UITableView {
    return tableView
  }
}

