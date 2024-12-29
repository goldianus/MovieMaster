//
//  HomeViewModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
  @Published var nowPlayingMovies: [Movie] = []
  @Published var popularMovies: [PopularResult] = []
  @Published var error: MovieError?
  @Published var isLoading = false
  @Published var currentPage = 1
  @Published var totalPages = 1
  
  private let interactor: MovieInteractor
  private var cancellables = Set<AnyCancellable>()
  
  init(interactor: MovieInteractor) {
    self.interactor = interactor
  }
  
  // MARK: - Private Methods
  private func fetchNowPlaying() {
    guard !isLoading else { return }
    setLoading(true)
    
    interactor.getNowPlaying()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        self?.handleCompletion(completion)
      }, receiveValue: { [weak self] response in
        self?.handleNowPlayingResponse(response)
      })
      .store(in: &cancellables)
  }
  
  private func fetchPopularMovies() {
    guard !isLoading else { return }
    setLoading(true)
    
    interactor.getPopular()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        self?.handleCompletion(completion)
      }, receiveValue: { [weak self] response in
        self?.handlePopularResponse(response)
      })
      .store(in: &cancellables)
  }
  
  // MARK: - Helper Methods
  private func setLoading(_ loading: Bool) {
    isLoading = loading
  }
  
  private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
    setLoading(false)
    if case .failure = completion {
      error = .failedToLoadMovies
    }
  }
  
  private func handleNowPlayingResponse(_ response: MovieResponse) {
    totalPages = response.totalPages
    nowPlayingMovies = response.results
  }
  
  private func handlePopularResponse(_ response: PopularMoviesResponse) {
    popularMovies = response.results
  }
  
  func fetchAllMovies() {
    self.fetchNowPlaying()
    self.fetchPopularMovies()
  }
}
