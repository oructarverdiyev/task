//
//  NavigationRouter.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit

class NavigationRouter: NSObject {
  
  public var navigation: UINavigationController
  private var rootController: UIViewController?
  private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
  
  init(with navigationController: UINavigationController) {
    self.navigation = navigationController
    self.rootController = navigationController.viewControllers.last
    super.init()
  }
}

extension NavigationRouter: Router {
  var last: UIViewController {
    return navigation.viewControllers.last ?? UIViewController()
  }
  
  func present(_ viewController: UIViewController, animated: Bool,
               onDismissed: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismissed
    navigation.pushViewController(viewController, animated: animated)
  }
  
  func presentModally(_ viewController: UIViewController, animated: Bool,
                      onDismissed: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismissed
    last.present(viewController, animated: animated)
  }
  
  func pop(animated: Bool) {
    guard let viewController = navigation.viewControllers.last else {
      navigation.popToRootViewController(animated: animated)
      return
    }
    performOnDismissed(for: viewController)
    navigation.popViewController(animated: animated)
  }
  
  func performOnDismissed(for viewController: UIViewController) {
    guard let onDismiss = onDismissForViewController[viewController] else {
      return
    }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }
}
