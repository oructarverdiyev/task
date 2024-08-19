//
//  LoginViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController
import Combine

protocol LoginFlow: AnyObject {
  func navigateHome()
  func navigateRegister()
}

final class LoginViewController: BaseViewController {
  
  private let viewModel: LoginViewModel!
  
  weak var flow: LoginFlow?
  
  private let loginView = LoginView()
  
  init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBinds()
  }
  
  private func setupBinds() {
    loginView.loginTapped
      .sink { [weak self] user in
        
        guard let self = self else { return }
        self.viewModel.login(user: user)
        
      }.store(in: &cancellables)
    
    loginView.registerTapped
      .sink { [weak self] in
        
        guard let self = self else { return }
        self.flow?.navigateRegister()
        
      }.store(in: &cancellables)
    
    viewModel.authorize
      .sink { [weak self] result in
        
        guard let self = self else { return }
        switch result {
        case .success:
          self.flow?.navigateHome()
        case .fail:
          self.showAlert()
        }
        
      }.store(in: &cancellables)
  }
  
  private func showAlert() {
    Alerts.shared.show(alert: Alert(title: "Xəta",
                                    message: "İstifadəçi adı vəya şifrə yanlışdır!"),
                       from: self,
                       handler: {})
  }
}
