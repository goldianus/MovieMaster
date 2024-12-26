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
    guard !isLoading else { return }
    isLoading = true
    
    interactor.getPopular()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        if case .failure(let error) = completion {
          self?.error = .failedToLoadMovies
          print("Popular movies error: \(error)")
        }
      } receiveValue: { [weak self] response in
        guard let self = self else { return }
        
        self.popularMovies = response.results
        
//        if !response.results.isEmpty {
//          self.popularMovies = response.results
//          self.totalPages = response.totalPage
//          print("Received popular movies count: \(response.results.count)")
//        }
      }
      .store(in: &cancellables)
  }
  
  func fetchAllMovies() {
    fetchNowPlaying()
    fetchPopularMovies()
  }
}
