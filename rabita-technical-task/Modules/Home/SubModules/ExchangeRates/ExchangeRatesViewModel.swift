//
//  ExchangeRatesViewModel.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import SWXMLHash
import Foundation
import Combine

final class ExchangeRatesViewModel: ViewModel {
  
  var segmentType: ExchangeSegmentType = .withoutCash
  
  init() {
    getRates()
  }
  
  var rates: [ExchangeSegmentType: [ExchangeRateCellViewModel]] = [
    .withoutCash: [],
    .withCash: []
  ]
  
  func getRates() {
    let regex = ["USD", "EUR", "RUB"]
    guard let savedRates = UserDefaults.standard.currencies else { return }
    let filteredRates = savedRates.filter{ regex.contains($0.code) }
    rates[.withoutCash] = filteredRates.map {
      ExchangeRateCellViewModel(valueType: .init(rawValue: $0.code) ?? .USD,
                                buyPrice: $0.buyValue*0.09,
                                salePrice: $0.saleValue*0.09)
    }
    
    rates[.withCash] = filteredRates.map {
      ExchangeRateCellViewModel(valueType: .init(rawValue: $0.code) ?? .USD,
                                buyPrice: $0.buyValue,
                                salePrice: $0.saleValue)
    }
  }
}
