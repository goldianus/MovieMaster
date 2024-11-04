//
//  NowPlayingModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 03/11/24.
//

import Foundation

// MARK: - NowPlayingMoviesModel
struct NowPlayingMoviesModel: Codable {
  var dates: Dates
  var page: Int
  var results: [Result]
  var totalPages: Int
  var totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case dates
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Dates
struct Dates: Codable {
  var maximum: String
  var minimum: String
}

// MARK: - Result
struct Result: Codable {
  var adult: Bool
  var backdropPath: String
  var genreIDS: [Int]
  var id: Int
  var originalLanguage: String
  var originalTitle: String
  var overview: String
  var popularity: Double
  var posterPath: String
  var releaseDate: String
  var title: String
  var video: Bool
  var voteAverage: Double
  var voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
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
