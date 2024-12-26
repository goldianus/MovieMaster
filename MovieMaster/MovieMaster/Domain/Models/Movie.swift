//
//  Movie.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation

struct MovieResponse {
  let results: [Movie]
  let totalPages: Int
}

struct PopularMoviesResponse {
  let results: [PopularResult]
  let totalPage: Int
}
