//
//  HomeView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import SwiftUI

struct HomeView: View {
  @State private var showMainView = false
  @State private var isLogoAnimated = false
  @StateObject private var viewModel: MoviesViewModel
  
  init(viewModel: MoviesViewModel = Injection.shared.provideMoviesViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 20) {
          // Now Playing section with Movie type
          HomeMovieCarouselSection<Movie>(
            title: "Now Playing",
            movies: viewModel.nowPlayingMovies
          )
          
          // Popular section with ResultPopular type
          HomeMovieCarouselSection<ResultPopular>(
            title: "Popular",
            movies: viewModel.popularMovies
          )
        }
        .padding()
      }
      
      .refreshable {
        viewModel.fetchAllMovies()
      }
      .background(.clear)
      .onAppear {
        viewModel.fetchAllMovies()
      }
      .navigationTitle("Movie Time")
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 1.5)) {
        isLogoAnimated.toggle()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        showMainView = true
      }
    }
  }
}

#Preview {
  HomeView()
}
