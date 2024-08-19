//
//  HomeCollectionViewCellType.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

enum HomeCollectionViewCellType: CaseIterable {
  case converter, rates, support, logout
  
  var title: String {
    switch self {
    case .converter:
      return "Konvertasiya"
    case .rates:
      return "Valyuta"
    case .support:
      return "Dəstək"
    case .logout:
      return "Çıxış"
    }
  }
  
  var subTitle: String {
    switch self {
    case .converter:
      return "Valyuta konvertoru"
    case .rates:
      return "Valyuta məzənnələri"
    case .support:
      return "Bizimlə əlaqə"
    default:
      return ""
    }
  }
}
