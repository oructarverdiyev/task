//
//  APIRequest.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import Foundation

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
}

struct APIRequest {
  let url: URL
  let method: HTTPMethod
  let headers: [String: String]?
  let queryParams: [String: Any]?
  let body: Data?
}
