//
//  HomeMovieCarouselSection.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import SwiftUI

struct HomeMovieCarouselSection: View {
  let title: String
  let movies: [Movie]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.title2)
        .fontWeight(.bold)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 15) {
          ForEach(movies) { movie in
            MovieRowView(movie: movie)
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
