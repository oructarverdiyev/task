//
//  AppCordinator.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController

final class AppCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router:  Router
  
  init(router: Router) {
    self.router = router
    setupObservers()
  }
  
  func present(animated: Bool = true, onDismissed: (() -> Void)? = nil) {
    
    guard UserDefaults.standard.token != nil else {
      let coordinator = AuthCoordinator(with: router)
      self.presentChild(coordinator,
                        animated: true,
                        onDismissed: nil)
      return
    }
    
    let coordinator = HomeCoordinator(with: router)
    self.presentChild(coordinator,
                      animated: true,
                      onDismissed: nil)
  }
  
  private func setupObservers() {
    let notify = NotificationCenter.default
    notify.addObserver(self,
                       selector: #selector(showHomeView),
                       name: .showHome,
                       object: nil)
    
    notify.addObserver(self,
                       selector: #selector(logout),
                       name: .logout,
                       object: nil)
  }
  
  @objc private func showHomeView() {
      clear()
    
      let coordinator = HomeCoordinator(with: self.router)
      presentChild(coordinator, animated: true, onDismissed: nil)
  }
  
  @objc private func logout() {
    UserDefaults.standard.token = nil
    clear()
    present(animated: true, onDismissed: nil)
  }
}
