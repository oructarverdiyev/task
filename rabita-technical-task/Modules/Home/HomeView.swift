//
//  HomeView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import UIKit.UIView
import Combine

final class HomeView: UIView {
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 20
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.register(HomeCollectionViewCell.self,
                            forCellWithReuseIdentifier: HomeCollectionViewCell.reuseId)
    
    return collectionView
  }()
  
  func getCollectionView() -> UICollectionView {
    return collectionView
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    appendSubview(collectionView)
    collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
}
