//
//  HomeViewModel.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import Foundation
import Combine
import SWXMLHash

final class HomeViewModel: ViewModel {
  
  let types = HomeCollectionViewCellType.allCases
  private let client: NetworkClient
  
  let animate = PassthroughSubject<Void, Never>()
  let response = PassthroughSubject<Void, Never>()
  
  init() {
    self.client = URLSessionApiClient()
  }
  
  func getRates() {
    animate.send()
    let date = Date().formattedDate
    guard let api = URL(string: "https://www.cbar.az/currencies/\(date).xml") else {
      return
    }
    
    let apiRequest = APIRequest(url: api,
                                method: .GET,
                                headers: nil,
                                queryParams: nil,
                                body: nil)
    
    client.dataTask(apiRequest) { [weak self] (_ result: Result<Data, Error>) in
      switch result {
      case .success(let data):
        self?.parseXML(data)
      case .failure:
        self?.response.send()
      }
    }
  }
  
  func parseXML(_ data: Data) {
    let xml = XMLHash.parse(data)
    let valutes = xml["ValCurs"]["ValType"][1]["Valute"].all
    let currencies: [Currency] = valutes.map{
      let buyValue = Double($0[0]["Value"].element?.text ?? "") ?? 0
      let saleValue = buyValue * 0.9
      return Currency(code: $0[0].element?.attribute(by: "Code")?.text ?? "",
                      name: $0[0]["Name"].element?.text ?? "",
                      buyValue: buyValue,
                      saleValue: saleValue)
    }
    UserDefaults.standard.currencies = currencies
    
    response.send()
  }
}
