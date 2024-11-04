//
//  APIClient.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import Foundation
import Combine


protocol MovieServiceProtocol {
  func getNowPlaying() -> AnyPublisher<NowPlayingResponse, Error>
  func fetchPopular() -> AnyPublisher<PopularMoviesResponse, Error>
}

//TODO: refactore moview serviceprovide data
class MovieService: MovieServiceProtocol {
  private let apiKey = "ENTER_YOUR_API_KEY"
  private let baseURL = "https://api.themoviedb.org/3"
  private let imagePath = "https://image.tmdb.org/t/p/original"
  
  let apiClient = URLSessionAPIClient<MovieEndpoint>()
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func getNowPlaying() -> AnyPublisher<NowPlayingResponse, Error> {
    return apiClient.request(.getNowPlayingMoviesList)
  }
  
  func fetchPopular() -> AnyPublisher<PopularMoviesResponse, Error> {
    guard let urlString = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)") else {
      return Fail(error: MovieError.invalidResponse)
        .eraseToAnyPublisher()
    }
    
    return fetchData(for: urlString)
  }
  
  private func fetchData<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .tryMap({ data, response in
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
          throw URLError(.badServerResponse)
        }
        return data
      })
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}

protocol APIClient {
  associatedtype EndpointType: APIEndpoint
  func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
  func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
    let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    
    endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          throw APIError.invalidResponse
        }
        return data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
