//
//  HomeViewModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
  @Published private(set) var movies: [Result] = []
  @Published var isLoading = false
  @Published var error: MovieError?
  @Published var currentPage: Int = 1
  @Published var totalPages: Int = 1
  
  private var movieService = MovieService()
  private var cancellables = Set<AnyCancellable>()
  
  init(movieService: MovieService = MovieService()) {
    self.movieService = movieService
  }
  
  func fetchNowPlaying() {
    guard !isLoading else { return }
    
    isLoading = true
    error = nil
    
    movieService.getNowPlaying()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        switch completion {
        case .finished:
          break
        case .failure(let error):
          self?.error = .failedToLoadMovies
          self?.movies = []
          print("Error: \(error.localizedDescription)")
        }
      } receiveValue: { [weak self] nowPlayingMovies in
      
      }
      .store(in: &cancellables)
  }
  
  func retry() {
    fetchNowPlaying()
  }
  
  func clearError() {
    error = nil
  }
}
