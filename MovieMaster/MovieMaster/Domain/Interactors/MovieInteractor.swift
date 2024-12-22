//
//  MovieInteractor.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation
import Combine

protocol MovieInteractor {
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error>
}

class DefaultMovieInteractor: MovieInteractor {
  private let repository: MovieRepositoryProtocol
  
  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error> {
    return repository.getNowPlaying()
  }
}
