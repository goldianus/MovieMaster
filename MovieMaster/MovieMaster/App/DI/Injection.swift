//
//  Injection.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation
import Combine

final class Injection {
  private init() {}
  
  static let shared = Injection()
  
  // MARK: - Data Layer
  func provideMovieRemoteDataSource() -> MovieRemoteDataSource {
    let apiClient = MovieService()
    return DefaultMovieRemoteDataSource(apiClient: apiClient)
  }
  
  func provideMovieRepository() -> MovieRepositoryProtocol {
    let remoteDataSource = provideMovieRemoteDataSource()
    return MovieRepository(remoteDataSource: remoteDataSource)
  }
  
  // MARK: - Domain Layer
  func provideGetNowPlayingMoviesUseCase() -> MovieInteractor {
    return DefaultMovieInteractor(repository: provideMovieRepository())
  }
  
  // MARK: - Presentation Layer
  func provideMoviesViewModel() -> MoviesViewModel {
    return MoviesViewModel(interactor: provideGetNowPlayingMoviesUseCase())
  }
}
