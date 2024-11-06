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
  private let apiClient: URLSessionAPIClient<MovieEndpoint>
  private let session: URLSession
  private let imagePath = "https://image.tmdb.org/t/p/original"
  
  init(
    apiClient: URLSessionAPIClient<MovieEndpoint> = URLSessionAPIClient(),
    session: URLSession = .shared
  ) {
    self.apiClient = apiClient
    self.session = session
  }
  
  func getNowPlaying() -> AnyPublisher<NowPlayingResponse, Error> {
    return apiClient.request(.getNowPlayingMoviesList)
  }
  
  func fetchPopular() -> AnyPublisher<PopularMoviesResponse, Error> {
    return apiClient.request(.getPopularList)
  }
}
