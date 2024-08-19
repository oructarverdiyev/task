//
//  ExchangeRatesViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UIViewController
import Combine

final class ExchangeRatesViewController: BaseViewController {
  
  private let viewModel: ExchangeRatesViewModel!
  private let exchangeRatesView = ExchangeRatesView()
  
  init(viewModel: ExchangeRatesViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = exchangeRatesView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    setupBinds()
    viewModel.getRates()
  }
  
  private func setupTableView() {
    exchangeRatesView.getTableView().delegate = self
    exchangeRatesView.getTableView().dataSource = self
  }
  
  private func setupBinds() {
    exchangeRatesView.segmentChanged
      .sink { [weak self] value in
        guard let type = ExchangeSegmentType(rawValue: value) else { return }
        self?.viewModel.segmentType = type
        DispatchQueue.main.async {
          self?.exchangeRatesView.getTableView().reloadData()
        }
      }.store(in: &cancellables)
  }
}

extension ExchangeRatesViewController: UITableViewDelegate,
                                       UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int
  ) -> Int {
    
    guard let dataSource = viewModel.rates[viewModel.segmentType] else { return 0 }
    return dataSource.count
    
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateCell.reuseId,
                                                   for: indexPath) as? ExchangeRateCell else {
      return UITableViewCell()
    }
    
    let dataSource = viewModel.rates[viewModel.segmentType]
    let model = dataSource?[indexPath.row]
    cell.configure(with: model)
    
    return cell
    
  }
}
