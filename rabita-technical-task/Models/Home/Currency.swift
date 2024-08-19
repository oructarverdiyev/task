//
//  Currency.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import Foundation
import SWXMLHash

struct Currency: Codable, Equatable {
  let code: String
  let name: String
  let buyValue: Double
  let saleValue: Double
}
