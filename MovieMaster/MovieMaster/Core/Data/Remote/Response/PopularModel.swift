//
//  PopularModel.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 03/11/24.
//

import Foundation

// MARK: - Popular
struct Popular: Codable {
  var page: Int?
  var results: [PopularResult]?
  var totalPages, totalResults: Int?
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
struct PopularResult: Codable, Hashable {
  let adult: Bool?
  let backdropPath: String?
  let genreIDS: [Int]?
  let id: Int?
  let originalLanguage: String?
  let originalTitle: String?
  let overview: String?
  let popularity: Double?
  let posterPath: String?
  let releaseDate: String?
  let title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?
  
  // Add initializer
  init(
    adult: Bool? = nil,
    backdropPath: String? = nil,
    genreIDS: [Int]? = nil,
    id: Int? = nil,
    originalLanguage: String? = nil,
    originalTitle: String? = nil,
    overview: String? = nil,
    popularity: Double? = nil,
    posterPath: String? = nil,
    releaseDate: String? = nil,
    title: String? = nil,
    video: Bool? = nil,
    voteAverage: Double? = nil,
    voteCount: Int? = nil
  ) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.genreIDS = genreIDS
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
    self.video = video
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview
    case popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

public enum OriginalLanguage: String, Codable {
  case en
  case fr
  case tl
}
