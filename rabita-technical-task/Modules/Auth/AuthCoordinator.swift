//
//  AuthCoordinator.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController

final class AuthCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router: Router
  lazy var navigationRouter = NavigationRouter(with: router.navigation)
  
  init(with router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewModel = LoginViewModel()
    let controller = LoginViewController(viewModel: viewModel)
    controller.flow = self
    router.present(controller, animated: true)
  }
}

extension AuthCoordinator: LoginFlow {
  func navigateHome() {
    NotificationCenter.dispatch(name: .showHome)
  }
  
  func navigateRegister() {
    let viewModel = RegisterViewModel()
    let controller = RegisterViewController(viewModel: viewModel)
    controller.flow = self
    navigationRouter.present(controller, animated: true)
  }
}

extension AuthCoordinator: RegisterFlow {
  func pop() {
    navigationRouter.pop(animated: true)
  }
}
