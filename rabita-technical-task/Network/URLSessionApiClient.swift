//
//  URLSessionApiClient.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import Foundation

final class URLSessionApiClient: NetworkClient {
  
  private let configuration: URLSessionConfiguration
  private let session: URLSession
  
  init() {
    self.configuration = URLSessionConfiguration.default
    self.configuration.timeoutIntervalForRequest = 30.0
    self.configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
    
    self.session = URLSession(configuration: self.configuration)
  }
  
  private func prepareURL(_ api: APIRequest) -> URL? {
    
    var urlComponents = URLComponents(string: api.url.absoluteString)
    let queryItems = api.queryParams?.map({ (key, value) in
      return URLQueryItem(name: key, value: String(describing: value) )
    })
    urlComponents?.queryItems = queryItems
    return urlComponents?.url
  }
  
  func dataTask<T: Codable>(_ api: APIRequest,
                            onCompletion: @escaping (_ result: Result<T, Error>) -> Void) {
    
    guard let url = prepareURL(api) else {
      return onCompletion(.failure(NetworkError.invalidURL))
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = api.method.rawValue
    urlRequest.allHTTPHeaderFields = api.headers
    urlRequest.httpBody = api.body
    
    self.session.dataTask(with: urlRequest) { data, response, error in
      
      if let err = error {
        onCompletion(.failure(err))
        return
      }
      
      guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
        onCompletion(.failure(NetworkError.httpFailure))
        return
      }
      
      if let data = data {
        guard api.url.absoluteString.contains(".xml"),
              let xmlData = data as? T else {
          onCompletion(.failure(NetworkError.xmlError))
          return
        }
        onCompletion(.success(xmlData))
        if let userModel = try? JSONDecoder().decode(T.self, from: data) {
          onCompletion(.success(userModel))
        } else {
          onCompletion(.failure(NetworkError.decodingError))
        }
      } else {
        onCompletion(.failure(NetworkError.noHttpBody))
      }
    }.resume()
  }
}
