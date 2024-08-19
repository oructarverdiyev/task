//
//  BaseViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UIViewController
import Combine

class BaseViewController: UIViewController {
  
  let activityIndicator = UIActivityIndicatorView()
  var cancellables = Set<AnyCancellable>()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension BaseViewController {
  func startAnimating() {
    DispatchQueue.main.async {
      self.activityIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.5)
      self.activityIndicator.color = .systemGreen
      self.activityIndicator.hidesWhenStopped = true
      self.activityIndicator.style = .large
      
      self.view.appendSubview(self.activityIndicator)
      self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
      self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
      self.view.isUserInteractionEnabled = false
      self.activityIndicator.startAnimating()
    }
  }
  
  func stopAnimating() {
    DispatchQueue.main.async {
      self.activityIndicator.removeFromSuperview()
      self.view.isUserInteractionEnabled = true
      self.activityIndicator.stopAnimating()
    }
  }
}
