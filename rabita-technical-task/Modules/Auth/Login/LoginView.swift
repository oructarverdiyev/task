//
//  LoginView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIView
import Combine

final class LoginView: UIView {
  
  let loginTapped = PassthroughSubject<User, Never>()
  let registerTapped = PassthroughSubject<Void, Never>()
  
  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "Xoş gəlmisiniz"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .medium)
    
    return label
  }()
  
  private let userNameField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "İstifadəçi adı"
    
    return textField
  }()
  
  private let passwordField: UITextField = {
    let textField = UITextField()
    textField.isSecureTextEntry = true
    textField.borderStyle = .roundedRect
    textField.placeholder = "Şifrə"
    
    return textField
  }()
  
  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Daxil ol", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    button.backgroundColor = .green
    button.layer.cornerRadius = 8
    
    return button
  }()
  
  private let registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Qeydiyyatdan keç", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
    button.setTitleColor(.systemBlue, for: .normal)
    
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    buttonActions()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    
    backgroundColor = .white
    
    let passwordRegisterButtonStack = UIStackView(arrangedSubviews: [registerButton],
                                                  axis: .vertical,
                                                  distribution: .fillProportionally,
                                                  alignment: .trailing)
    
    let stackView = UIStackView(arrangedSubviews: [userNameField,
                                                   passwordField,
                                                   passwordRegisterButtonStack,
                                                   loginButton],
                                axis: .vertical,
                                distribution: .fillProportionally,
                                spacing: 10)
    
    stackView.setCustomSpacing(40, after: passwordRegisterButtonStack)
    
    userNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    appendSubview(welcomeLabel)
    appendSubview(stackView)
    
    welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyboard))
    addGestureRecognizer(gesture)
  }
  
  private func buttonActions() {
    loginButton.addAction(UIAction { [weak self]_ in
      
      guard let self = self else { return }
      
      let user = User(userName: self.userNameField.text ?? "",
                      password: self.passwordField.text ?? "")
      
      self.loginTapped.send(user)
      
    }, for: .touchUpInside)
    
    registerButton.addAction(UIAction { [weak self] _ in
      
      self?.registerTapped.send()
      
    }, for: .touchUpInside)
  }
  
  @objc private func handleKeyboard() {
    endEditing(true)
  }
}
