//
//  HomeCoordinator.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController
import FloatingPanel

final class HomeCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router:  Router
  
  init(with router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewModel = HomeViewModel()
    let controller = HomeViewController(viewModel: viewModel)
    controller.flow = self
    router.present(controller, animated: true)
  }
}

extension HomeCoordinator: HomeFlow {
  func showExchangeRates() {
    let viewModel = ExchangeRatesViewModel()
    let controller = ExchangeRatesViewController(viewModel: viewModel)
    let bottomSheet = BottomSheetViewController(with: .halfWithGrabber(0.4))
    bottomSheet.set(contentViewController: controller)
    bottomSheet.addPanel(toParent: router.last, animated: true)
    bottomSheet.dismissalEnabled(with: true)
  }
  
  func showConverter() {
    let viewModel = ConverterViewModel()
    let controller = ConverterViewController(viewModel: viewModel)
    router.presentModally(controller,
                          animated: true,
                          onDismissed: nil)
  }
  
  func logout() {
    NotificationCenter.dispatch(name: .logout)
  }
}
