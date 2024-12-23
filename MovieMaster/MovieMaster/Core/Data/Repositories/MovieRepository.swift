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
  
  func getPopular() -> AnyPublisher<MoviePopularMoviesResponse, any Error> {
    return remoteDataSource.getPopular()
  }
  
}
