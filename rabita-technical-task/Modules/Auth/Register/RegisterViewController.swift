//
//  RegisterViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIViewController

protocol RegisterFlow: AnyObject {
  func pop()
}

final class RegisterViewController: BaseViewController {
  
  private let viewModel: RegisterViewModel!
  private let registerView = RegisterView()
  
  weak var flow: RegisterFlow?
  
  init(viewModel: RegisterViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = registerView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBinds()
  }
  
  private func setupBinds() {
    viewModel.registered
      .sink { [weak self] in
        guard let self = self else { return }
        
        Alerts.shared.show(alert: Alert(title: "Uğurlu",
                                        message: "Qeydiyyat uğurla tamamlandı!"),
                           from: self) {
          self.flow?.pop()
        }
      }.store(in: &cancellables)
    
    registerView.registerAction
      .sink { [weak self] user in
        self?.viewModel.saveUser(user: user)
      }.store(in: &cancellables)
  }
}
