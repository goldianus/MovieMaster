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
  func getPopular() -> AnyPublisher<MoviePopularMoviesResponse, Error>
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
  
  func getPopular() -> AnyPublisher<MoviePopularMoviesResponse, Error> {
    return apiClient.getPopular()
      .map(mapToPopularResponse)
      .eraseToAnyPublisher()
  }
  
  private func mapToPopularResponse(_ response: Popular) -> MoviePopularMoviesResponse {
    let movies = response.results.compactMap(mapToPopular)
    return MoviePopularMoviesResponse(
      result: movies,
      totalPage: response.totalPages
    )
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
  
  private func mapToPopular(_ result: Result) -> Result? {
    return Result(
      adult: result.adult,
      backdropPath: result.backdropPath,
      genreIDS: result.genreIDS,
      id: result.id,
      originalLanguage: result.originalLanguage,
      originalTitle: result.originalTitle,
      overview: result.overview,
      popularity: result.popularity,
      posterPath: result.posterPath,
      releaseDate: result.releaseDate,
      title: result.title,
      video: result.video,
      voteAverage: result.voteAverage,
      voteCount: result.voteCount
    )
  }
}
