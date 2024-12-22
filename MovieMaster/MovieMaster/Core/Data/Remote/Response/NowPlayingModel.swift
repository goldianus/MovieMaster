//
//  NowPlayingModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 03/11/24.
//

import Foundation

// MARK: - NowPlayingMoviesModel
struct NowPlayingResponse: Codable {
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

struct Movie: Codable, Identifiable {
  let id: Int
  let title: String
  let overview: String
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String
  let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
  }
}

enum MovieError: LocalizedError {
  case failedToLoadMovies
  case invalidResponse
  
  var errorDescription: String? {
    switch self {
    case .failedToLoadMovies:
      return "Gagal memuat data film. Silakan coba lagi."
    case .invalidResponse:
      return "Terjadi kesalahan pada response server."
    }
  }
}
