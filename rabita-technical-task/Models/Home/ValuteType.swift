//
//  ValuteType.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

enum ValuteType: String {
  case AZN, USD, EUR, RUB, GBP
  
  var valuteCodeString: String {
    switch self {
    case .AZN:
      return "₼"
    case .USD:
      return "$"
    case .EUR:
      return "€"
    case .RUB:
      return "₽"
    case .GBP:
      return "£"
    }
  }
  
  var icon: String {
    switch self {
    case .USD:
      return "currency_usd"
    case .EUR:
      return "currency_eur"
    case .RUB:
      return "currency_rub"
    default:
      return ""
    }
  }
}
