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
  
  var body: some View {
    let dataProvider = MovieService()
    let viewModel = MoviesViewModel(movieService: dataProvider)
    
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack() {
          ForEach (viewModel.movies, id: \.self.id) { movie in
            MovieRowView(movie: movie)
          }
        }
      }
      .navigationTitle("Now Playing")
      
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
