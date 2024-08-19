//
//  RegisterView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

import UIKit.UIView
import Combine

final class RegisterView: UIView {
  
  let registerAction = PassthroughSubject<User, Never>()
  
  private let headLabel: UILabel = {
    let label = UILabel()
    label.text = "Qeydiyyatdan keçin"
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
  
  private let registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Qeydiyyatdan keç", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    button.backgroundColor = .green
    button.layer.cornerRadius = 8
    
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    registerButtonAction()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    
    backgroundColor = .white
    
    let stackView = UIStackView(arrangedSubviews: [userNameField, passwordField, registerButton],
                                axis: .vertical,
                                distribution: .fillProportionally,
                                spacing: 10)
    
    stackView.setCustomSpacing(40, after: passwordField)
    
    userNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    appendSubview(headLabel)
    appendSubview(stackView)
    
    headLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    headLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    headLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    stackView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 40).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyboard))
    addGestureRecognizer(gesture)
  }
  
  private func registerButtonAction() {
    registerButton.addAction(UIAction { [weak self] _ in
      guard let self = self else { return }
      let user = User(userName: self.userNameField.text ?? "",
                      password: self.passwordField.text ?? "")
      self.registerAction.send(user)
    }, for: .touchUpInside)
  }
  
  @objc private func handleKeyboard() {
    endEditing(true)
  }
}
