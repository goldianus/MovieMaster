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

class MovieService: MovieServiceProtocol {
  private let apiKey = "ENTER_YOUR_API_KEY"
  private let baseURL = "https://api.themoviedb.org/3"
  private let imagePath = "https://image.tmdb.org/t/p/original"
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func getNowPlaying() -> AnyPublisher<NowPlayingResponse, Error> {
    guard let urlString = URL(string:  "\(baseURL)/movie/now_playing?language=en-US&page=1&api_key=\(apiKey)") else {
      return Fail(error: MovieError.invalidResponse)
        .eraseToAnyPublisher()
    }
    return fetchData(for: urlString)
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
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
