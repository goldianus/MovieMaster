//
//  NetworkService.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 26/12/24.
//

import Foundation

class NetworkService {
  func fetch<T: Decodable>(url: URL) async throws -> T {
    let request = URLRequest(url: url)
    
    // Log the request
    NetworkLogger.log(request: request)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // Log the response
    NetworkLogger.log(response: response, data: data, error: nil)
    
    return try JSONDecoder().decode(T.self, from: data)
  }
}
