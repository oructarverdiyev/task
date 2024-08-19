//
//  ConverterViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import UIKit.UIViewController

final class ConverterViewController: BaseViewController {
  
  private let viewModel: ConverterViewModel!
  private let converterView = ConverterView()
  
  init(viewModel: ConverterViewModel!) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = converterView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupBinds()
  }
  
  private func setupTableView() {
    converterView.getTableView().delegate = self
    converterView.getTableView().dataSource = self
  }
  
  private func setupBinds() {
    converterView.dismiss
      .sink { [weak self] in
        self?.dismiss(animated: true)
      }.store(in: &cancellables)
    
    converterView.segmentChanged
      .sink { [weak self] value in
        self?.viewModel.segmentType = .init(rawValue: value) ?? .buy
        self?.converterView.getTableView().reloadData()
      }.store(in: &cancellables)
    
    viewModel.updateRows
      .sink { [weak self] value in
        self?.reloadRows(activeRow: value)
      }.store(in: &cancellables)
  }
  
  private func reloadRows(activeRow: Int) {
    for index in 0...viewModel.currenciesDataSource.count-1 {
      if index != activeRow {
        converterView.getTableView().reloadRows(at: [IndexPath(row: index, section: 0)],
                                                with: .automatic)
      }
    }
  }
}

extension ConverterViewController: UITableViewDelegate,
                                   UITableViewDataSource {
  func numberOfSections(in tableView: UITableView
  ) -> Int {
      return 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.currenciesDataSource.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ConverterCell.reuseId,
                                                   for: indexPath) as? ConverterCell else {
      return UITableViewCell()
    }
    
    let model = viewModel.currenciesDataSource[indexPath.row]
    cell.configure(model: model,
                   type: viewModel.segmentType)
    
    cell.changed = { [weak self] value in
      self?.viewModel.calculate(value: value,
                                index: indexPath.item)
    }
    
    return cell
  }
}
