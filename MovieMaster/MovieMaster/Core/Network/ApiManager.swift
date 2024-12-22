//
//  ApiManager.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 06/11/24.
//

import Foundation
import Combine

protocol APIClient {
  associatedtype EndpointType: APIEndpoint
  func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
  private let apiKey = "ENTER_YOUR_API_KEY"
  
  func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
    var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
    var queryItems = urlComponents?.queryItems ?? []
    queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
    urlComponents?.queryItems = queryItems
    
    guard let url = urlComponents?.url else {
      return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
    }
    
    print("Final URL: \(url)")
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    print("Final Request: \(request)")
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          throw APIError.invalidResponse
        }
        return data
      }
      .receive(on: DispatchQueue.main)
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
