//
//  LoginViewModel.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import Foundation
import Combine

final class LoginViewModel: ViewModel {
  
  let authorize = PassthroughSubject<ResponseType, Never>()
  
  func login(user: User) {
    guard let savedUser = UserDefaults.standard.user,
    savedUser == user else {
      authorize.send(.fail)
      return
    }
    
    UserDefaults.standard.token = "logged"
    authorize.send(.success)
  }
}
