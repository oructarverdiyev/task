//
//  Notification+extension.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import Foundation.NSNotification

extension Notification.Name {
  static let showHome = Notification.Name("home")
  static let logout = Notification.Name("logout")
}

extension NotificationCenter {
  static func dispatch(name: Notification.Name, payload: [String: String] = [:]) {
    self.default.post(name: name, object: nil, userInfo: payload)
  }
}
