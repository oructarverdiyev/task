//
//  RegisterViewModel.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import Foundation
import Combine

final class RegisterViewModel: ViewModel {
  
  let registered = PassthroughSubject<Void, Never>()
  
  func saveUser(user: User) {
    guard user.userName != "" && user.password != "" else { return }
    if let savedUser = UserDefaults.local.user {
      guard savedUser != user else { return }
      UserDefaults.standard.user = user
    } else {
      UserDefaults.standard.user = user
    }
    
    registered.send()
  }
}
