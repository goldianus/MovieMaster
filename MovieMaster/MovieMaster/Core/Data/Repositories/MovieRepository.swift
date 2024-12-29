//
//  MovieRepository.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation
import Combine

class MovieRepository: MovieRepositoryProtocol {
  
  private let remoteDataSource: MovieRemoteDataSource
  
  init(remoteDataSource: MovieRemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }
  
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error> {
    return remoteDataSource.getNowPlaying()
  }
  
  func getPopular() -> AnyPublisher<PopularMoviesResponse, any Error> {
    return remoteDataSource.getPopular()
      .handleEvents(receiveSubscription: { _ in
        Debug.log("[Repository] Fetching popular movies")
      }, receiveCompletion: { completion in
        if case .failure(let error) = completion {
          Debug.log("[Repository] Error fetching popular movies: \(error)")
        }
      })
      .eraseToAnyPublisher()
  }
}
