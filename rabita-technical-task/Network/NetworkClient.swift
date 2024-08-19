//
//  NetworkClient.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import Foundation

protocol NetworkClient {
  func dataTask<T: Codable>(_ api: APIRequest,
                            onCompletion: @escaping (_ result: Result<T, Error>) -> Void)
}
