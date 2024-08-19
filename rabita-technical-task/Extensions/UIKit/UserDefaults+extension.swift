//
//  UserDefaults+extension.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import Foundation

extension UserDefaults {
  class var local: UserDefaults {
    return self.standard
  }
  
  var token: String? {
    get {
      UserDefaults.local.value(forKey: "token") as? String
    }
    set {
      UserDefaults.local.set(newValue, forKey: "token")
    }
  }
  
  var user: User? {
    get { 
      guard let data = UserDefaults.local.value(forKey: "user") as? Data else { return nil }
      guard let savedUser = try? JSONDecoder().decode(User.self, from: data) else { return nil }
      return savedUser
    }
    set {
      guard let data = try? JSONEncoder().encode(newValue) else { return }
      UserDefaults.local.set(data, forKey: "user")
    }
  }
  
  var currencies: [Currency]? {
    get {
      guard let data = UserDefaults.local.value(forKey: "currency") as? Data else { return nil }
      guard let savedCurrencies = try? JSONDecoder().decode([Currency].self, from: data) else { return nil }
      return savedCurrencies
    }
    set {
      guard let data = try? JSONEncoder().encode(newValue) else { return }
      UserDefaults.local.set(data, forKey: "currency")
    }
  }
}
