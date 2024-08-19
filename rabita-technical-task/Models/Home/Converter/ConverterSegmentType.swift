//
//  ConverterSegmentType.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 18.08.24.
//

enum ConverterSegmentType: Int, Segmentable {
  
  case buy = 0
  case sale = 1
  
  var title: String {
    switch self {
    case .buy:
      return "Alış"
    case .sale:
      return "Satış"
    }
  }
}
