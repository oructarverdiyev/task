//
//  AppDelegateRouter.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController

public final class AppDelegateRouter: Router {
  
  public let window: UIWindow
  public var navigation: UINavigationController
  public var last: UIViewController
  
  public init(window: UIWindow) {
    self.window = window
    self.navigation = UINavigationController()
    self.last = UIViewController()
  }
  
  public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    self.navigation = UINavigationController(rootViewController: viewController)
    self.last = viewController
    
    window.rootViewController = self.navigation
    window.makeKeyAndVisible()
    
    UIView.transition(with: window,
                      duration: 0.4,
                      options: .transitionCrossDissolve,
                      animations: {},
                      completion: nil)
  }
  
  public func presentModally(_ viewController: UIViewController, animated: Bool,
                             onDismissed: (() -> Void)?) {
    last.present(viewController, animated: animated)
  }
}
