//
//  Debug.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 29/12/24.
//

import Foundation

#if DEBUG
struct Debug {
  static var isLoggingEnabled = true
  
  static func log(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    guard isLoggingEnabled else { return }
    let fileName = (file as NSString).lastPathComponent
    print("📱 [\(fileName):\(line)] \(function) -> \(message)")
  }
}
#endif
