//
//  MovieRemoteDataSource.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation
import Combine

protocol MovieRemoteDataSource {
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error>
}

class DefaultMovieRemoteDataSource: MovieRemoteDataSource {
  private let apiClient: MovieServiceProtocol
  
  init(apiClient: MovieServiceProtocol) {
    self.apiClient = apiClient
  }
  
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error> {
    return apiClient.getNowPlaying()
      .map(mapToMovieResponse)
      .eraseToAnyPublisher()
  }
  
  private func mapToMovieResponse(_ response: NowPlayingResponse) -> MovieResponse {
    let movies = response.results.compactMap(mapToMovie)
    return MovieResponse(
      results: movies,
      totalPages: response.totalPages
    )
  }
  
  private func mapToMovie(_ result: Movie) -> Movie? {
    return Movie(
      id: result.id,
      title: result.title,
      overview: result.overview,
      posterPath: result.posterPath,
      backdropPath: result.backdropPath ?? "",
      releaseDate: result.releaseDate,
      voteAverage: result.voteAverage
    )
  }
}
