//
//  HomeViewModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
  @Published var nowPlayingMovies: [Movie] = []
  @Published var popularMovies: [Result] = []
  @Published var error: MovieError?
  @Published var isLoading = false
  @Published var currentPage = 1
  @Published var totalPages = 1
  
  private let interactor: MovieInteractor
  private var cancellables = Set<AnyCancellable>()
  
  init(interactor: MovieInteractor) {
    self.interactor = interactor
  }
  
  func fetchNowPlaying() {
    guard !isLoading else { return }
    isLoading = true
    
    interactor.getNowPlaying()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        if case .failure = completion {
          self?.error = .failedToLoadMovies
        }
      } receiveValue: { [weak self] response in
        self?.totalPages = response.totalPages
        self?.nowPlayingMovies = response.results
      }
      .store(in: &cancellables)
  }
  
  func fetchPopularMovies() {
    interactor.getPopular()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        if case .failure = completion {
          self?.error = .failedToLoadMovies
        }
      } receiveValue: { [weak self] response in
        guard let self = self else { return }
        self.totalPages = response.totalPage
        self.popularMovies = response.result
      }
      .store(in: &cancellables)
  }
  
  func fetchAllMovies() {
    fetchNowPlaying()
    fetchPopularMovies()
  }
}
