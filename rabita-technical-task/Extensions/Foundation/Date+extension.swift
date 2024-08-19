//
//  Date+extension.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import Foundation

extension Date {
  var formattedDate: String {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    let result = formatter.string(from: self)
    return result
  }
}
