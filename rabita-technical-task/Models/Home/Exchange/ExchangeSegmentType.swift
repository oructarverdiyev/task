//
//  ExchangeSegmentType.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

enum ExchangeSegmentType: Int, Segmentable {
  
  case withCash = 1
  case withoutCash = 0
  
  var title: String {
    switch self {
    case .withCash:
      return "Nağd"
    case .withoutCash:
      return "Nağdsız"
    }
  }
}
