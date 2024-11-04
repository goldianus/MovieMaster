//
//  APIEndpoint.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 05/11/24.
//

import Foundation

protocol APIEndpoint {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

enum APIError: Error {
  case invalidResponse
  case invalidData
}

enum MovieEndpoint: APIEndpoint {
  case getNowPlayingMoviesList
  case getPopularList
  
  var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }
  
  var path: String {
    switch self {
    case .getNowPlayingMoviesList:
      return "movie/now_playing?api_key="
    case .getPopularList:
      return "movie/popular?api_key="
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getNowPlayingMoviesList:
      return .get
    case .getPopularList:
      return .get
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .getNowPlayingMoviesList, .getPopularList:
      return ["Content-Type": "application/x-www-form-urlencoded"]
    }
  }
  
  var parameters: [String : Any]? {
    switch self {
    case .getNowPlayingMoviesList:
      return nil
    case .getPopularList:
      return nil
    }
  }
}
