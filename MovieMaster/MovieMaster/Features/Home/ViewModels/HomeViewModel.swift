//
//  HomeViewModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
  @Published var movies: [Movie] = []
  @Published var isLoading = false
  @Published var error: MovieError?
  
  @Published var currentPage = 1
  @Published var totalPages = 1
  
  private let movieService: MovieServiceProtocol
  private var cancellables = Set<AnyCancellable>()
  
  init(movieService: MovieServiceProtocol) {
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
      } receiveValue: { [weak self] response in
        self?.movies = response.results
        print("Received movies: \(response.results.count)")
      }
      .store(in: &cancellables)
  }
}
