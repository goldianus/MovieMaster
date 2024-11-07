//
//  PopularModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 03/11/24.
//

import Foundation

// MARK: - PopularMovies
public struct PopularMoviesResponse: Codable {
  public let page: Int?
  public let results: [ResultPopular]?
  public let totalPages, totalResults: Int?
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
public struct ResultPopular: Codable {
  public let adult: Bool?
  public let backdropPath: String?
  public let genreIDS: [Int]?
  public let id: Int?
  public let originalLanguage: OriginalLanguage?
  public let originalTitle, overview: String?
  public let popularity: Double?
  public let posterPath, releaseDate, title: String?
  public let video: Bool?
  public let voteAverage: Double?
  public let voteCount: Int?
  
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
  case en = "en"
  case fr = "fr"
  case tl = "tl"
}
