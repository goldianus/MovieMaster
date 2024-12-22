//
//  MovieRowView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 04/11/24.
//

import SwiftUI

struct MovieRowView: View {
  var movie: Movie
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(movie.title)
        .font(.headline)
      Text(movie.overview)
        .font(.subheadline)
        .lineLimit(2)
      Text("Rating: \(String(format: "%.1f", movie.voteAverage))")
        .font(.caption)
    }
    .padding(.vertical, 8)
  }
}
