//
//  HomeView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import SwiftUI

struct HomeView: View {
  @StateObject var viewModel: MoviesViewModel
  
  var body: some View {
    NavigationView {
      Group {
        if viewModel.isLoading {
          // Progress view
        } else {
          List(viewModel.movies) { movie in
            MovieRowView(movie: movie)
          }
        }
      }
      .navigationTitle("Now Playing")
      .alert("Error", isPresented: Binding(
        get: { viewModel.error != nil },
        set: { if !$0 { viewModel.error = nil } }
      )) {
        Text(viewModel.error?.localizedDescription ?? "")
      }
    }
    .onAppear {
      viewModel.fetchNowPlaying()
    }
  }
}

#Preview {
  MovieRowView(movie: Movie(
    id: 1,
    title: "Sample Movie",
    overview: "This is a sample movie description that might be long enough to demonstrate line limiting.",
    posterPath: nil,
    backdropPath: nil,
    releaseDate: "2024-01-01",
    voteAverage: 8.5
  ))
  .previewLayout(.sizeThatFits)
  .padding()
}
