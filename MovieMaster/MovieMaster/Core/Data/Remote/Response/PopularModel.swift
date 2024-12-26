//
//  PopularModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 03/11/24.
//

import Foundation

// MARK: - Popular
struct Popular: Codable {
  var page: Int
  var results: [Result]
  var totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
struct Result: Codable {
  var adult: Bool
  var backdropPath: String
  var genreIDS: [Int]
  var id: Int
  var originalLanguage: OriginalLanguage
  var originalTitle, overview: String
  var popularity: Double
  var posterPath, releaseDate, title: String
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
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

public enum OriginalLanguage: String, Codable {
  case en
  case fr
  case tl
}
