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
  func getPopular() -> AnyPublisher<PopularMoviesResponse, Error>
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
  
  func getPopular() -> AnyPublisher<PopularMoviesResponse, Error> {
    return apiClient.getPopular()
      .handleEvents(receiveSubscription: { _ in
        Debug.log("🔄 [RemoteDataSource] Starting API call")
      }, receiveOutput: { response in
        Debug.log("📥 [RemoteDataSource] Raw API Response: \(response)")
      })
      .map { [weak self] response -> PopularMoviesResponse in
        guard let self = self else {
          Debug.log("⚠️ [RemoteDataSource] Self is nil during mapping")
          return PopularMoviesResponse(results: [], totalPage: 0)
        }
        
        let mappedResponse = self.mapToPopularResponse(response)
        Debug.log("🔄 [RemoteDataSource] Mapped response: \(mappedResponse.results.count) items")
        return mappedResponse
      }
      .eraseToAnyPublisher()
  }
  
  private func mapToPopularResponse(_ response: Popular) -> PopularMoviesResponse {
    let movies = response.results?.compactMap { movie -> PopularResult? in
      Debug.log("🎬 [RemoteDataSource] Mapping movie: \(movie.title ?? "")")
      return mapToPopular(movie)
    }
    Debug.log("✅ [RemoteDataSource] Mapped \(String(describing: movies?.count)) movies successfully")
    return PopularMoviesResponse(
      results: movies ?? [],
      totalPage: response.totalPages ?? 0
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
  
  private func mapToPopular(_ result: PopularResult) -> PopularResult? {
    // Now we can use the custom initializer directly
    let mapped = PopularResult(
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
    
    Debug.log("✅ Successfully mapped popular result for ID: \(mapped.id ?? 0)")
    return mapped
  }
}
