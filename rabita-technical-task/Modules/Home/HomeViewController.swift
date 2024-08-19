//
//  HomeViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import UIKit.UIViewController

protocol HomeFlow: AnyObject {
  func logout()
  func showExchangeRates()
  func showConverter()
}

final class HomeViewController: BaseViewController {
  
  private let viewModel: HomeViewModel!
  
  weak var flow: HomeFlow?
  
  private let homeView = HomeView()
  
  init(viewModel: HomeViewModel
  ) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    view = homeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupBinds()
    viewModel.getRates()
  }
  
  private func setupCollectionView() {
    homeView.getCollectionView().dataSource = self
    homeView.getCollectionView().delegate = self
  }
  
  private func setupBinds() {
    viewModel.animate
      .sink { [weak self] in
        self?.startAnimating()
      }.store(in: &cancellables)
    
    viewModel.response
      .sink { [weak self] _ in
        self?.stopAnimating()
      }.store(in: &cancellables)
  }
  
  private func callSupport() {
    if let url = URL(string: "tel://133"), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      Alerts.shared.show(alert: Alert(title: "Xəta",
                                      message: "Zəng etmək mümkün olmadı"),
                         from: self,
                         handler: {})
    }
  }
}

extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.types.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HomeCollectionViewCell.reuseId,
      for: indexPath) as? HomeCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let item = viewModel.types[indexPath.item]
    cell.configure(with: item)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    let item = viewModel.types[indexPath.item]
    switch item {
    case .converter:
      flow?.showConverter()
    case .rates:
      flow?.showExchangeRates()
    case .support:
      callSupport()
    case .logout: 
      flow?.logout()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    
    let width = collectionView.frame.width / 2 - 30
    
    return CGSize(width: width, height: 120)
  }
}
