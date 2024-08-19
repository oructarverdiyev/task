//
//  NetworkError.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

enum NetworkError: Error {
  case invalidURL
  case noHttpBody
  case httpFailure
  case decodingError
  case xmlError
}
