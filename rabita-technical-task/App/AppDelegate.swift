//
//  AppDelegate.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//
  
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  public lazy var coordinator = AppCoordinator(router: router)
  public lazy var router = AppDelegateRouter(window: window!)
  public lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    coordinator.present(animated: true, onDismissed: nil)
    return true
  }
}

