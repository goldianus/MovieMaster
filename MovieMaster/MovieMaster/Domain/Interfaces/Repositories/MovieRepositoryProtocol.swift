//
//  MovieRepositoryProtocol.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 22/12/24.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
  func getNowPlaying() -> AnyPublisher<MovieResponse, Error>
}
