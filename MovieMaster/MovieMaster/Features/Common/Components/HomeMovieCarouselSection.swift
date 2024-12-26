//
//  HomeMovieCarouselSection.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import SwiftUI

protocol MovieDisplayable {
  var movieId: Int { get }
  var movieTitle: String { get }
  var movieOverview: String { get }
  var moviePosterPath: String? { get }
  var movieBackdropPath: String? { get }
  var movieReleaseDate: String { get }
  var movieVoteAverage: Double { get }
}

extension Movie: MovieDisplayable {
  var movieId: Int { id }
  var movieTitle: String { title }
  var movieOverview: String { overview }
  var moviePosterPath: String? { posterPath }
  var movieBackdropPath: String? { backdropPath }
  var movieReleaseDate: String { releaseDate }
  var movieVoteAverage: Double { voteAverage }
}

extension Result: MovieDisplayable {
  var movieId: Int { id }
  var movieTitle: String { title }
  var movieOverview: String { overview }
  var moviePosterPath: String? { posterPath }
  var movieBackdropPath: String? { backdropPath }
  var movieReleaseDate: String { releaseDate }
  var movieVoteAverage: Double { voteAverage }
}

struct HomeMovieCarouselSection<T: MovieDisplayable>: View {
  let title: String
  let movies: [T]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.title2)
        .fontWeight(.bold)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 15) {
          ForEach(movies, id: \.movieId) { movie in
            MovieRowView(movie: Movie(
              id: movie.movieId,
              title: movie.movieTitle,
              overview: movie.movieOverview,
              posterPath: movie.moviePosterPath,
              backdropPath: movie.movieBackdropPath,
              releaseDate: movie.movieReleaseDate,
              voteAverage: movie.movieVoteAverage
            ))
          }
        }
      }
    }
  }
}

#Preview {
  HomeMovieCarouselSection(
    title: "Test Section",
    movies: [
      Movie(
        id: 1,
        title: "Sample Movie",
        overview: "Sample description",
        posterPath: nil,
        backdropPath: nil,
        releaseDate: "2024-01-01",
        voteAverage: 8.5
      )
    ]
  )
  .previewLayout(.sizeThatFits)
  .padding()
}
