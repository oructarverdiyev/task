//
//  Alerts.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import UIKit.UIAlertController

final class Alerts {
  private init() {}
  
  static let shared = Alerts()
  
  func show(alert: Alert,
            from viewController: UIViewController,
            handler: @escaping () -> Void) {
    let alert = UIAlertController(title: alert.title,
                                  message: alert.message,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Oldu",
                                  style: .default, handler: { _ in handler() }))
    
    viewController.present(alert, animated: true)
  }
}

