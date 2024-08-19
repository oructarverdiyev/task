//
//  ConverterViewModel.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

import Foundation
import Combine

final class ConverterViewModel: ViewModel {
  
  var currencies: [Currency] = []
  var currenciesDataSource: [ConverterCellViewModel] = []
  var segmentType: ConverterSegmentType = .buy
  let updateRows = PassthroughSubject<Int, Never>()
  var activeRow: Int = -1
  
  init() {
    getCurrencies()
  }
  
  func getCurrencies() {
    let regex = ["USD", "EUR", "RUB", "GBP"]
    currencies = (UserDefaults.local.currencies ?? []).filter { regex.contains($0.code) }
    let newCurrency = Currency(code: "AZN", name: "1 Azərbaycan manatı", buyValue: 1, saleValue: 1)
    currencies.insert(newCurrency, at: 0)
    self.currenciesDataSource = currencies.map {
      ConverterCellViewModel(valuteType: ValuteType(rawValue: $0.code) ?? .AZN,
                             currencyName: $0.name,
                             buyPrice: $0.buyValue.rounded(toPlaces: 3),
                             salePrice: $0.saleValue.rounded(toPlaces: 3))
    }
  }
  
  func calculate(value: Double,
                 index: Int) {
    activeRow = index
    let activeCurrency = currencies[index]
    let activeValuteValue = segmentType == .buy ? activeCurrency.buyValue : activeCurrency.saleValue
    let manatValue = value * activeValuteValue
    for (index, currency) in currencies.enumerated() {
      if activeCurrency.code != currency.code {
        if segmentType == .buy {
          currenciesDataSource[index].buyPrice = (manatValue / currency.buyValue).rounded(toPlaces: 3)
        } else {
          currenciesDataSource[index].salePrice = (manatValue / currency.saleValue).rounded(toPlaces: 3)
        }
      }
    }
    
    updateRows.send(index)
  }
}
