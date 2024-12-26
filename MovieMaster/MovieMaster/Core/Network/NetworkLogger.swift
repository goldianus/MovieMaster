//
//  NetworkLogger.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 26/12/24.
//

import Foundation

class NetworkLogger {
  private static var logs: [String] = []
  
  static func log(request: URLRequest) {
    var logOutput = "\n - - - - - - - - - - REQUEST - - - - - - - - - - \n"
    
    let urlAsString = request.url?.absoluteString ?? ""
    let urlComponents = URLComponents(string: urlAsString)
    
    let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
    let path = "\(urlComponents?.path ?? "")"
    let query = "\(urlComponents?.query ?? "")"
    let host = "\(urlComponents?.host ?? "")"
    
    logOutput += "\(urlAsString)"
    logOutput += "\n\nMethod: \(method)"
    logOutput += "\nHost: \(host)"
    logOutput += "\nPath: \(path)"
    logOutput += "\nQuery: \(query)"
    
    if let headers = request.allHTTPHeaderFields {
      logOutput += "\nHeaders: \(headers)"
    }
    
    if let body = request.httpBody {
      logOutput += "\nBody: \(String(data: body, encoding: .utf8) ?? "")"
    }
    
    logs.append(logOutput)
    print(logOutput)
  }
  
  static func log(response: URLResponse?, data: Data?, error: Error?) {
    var logOutput = "\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n"
    
    let urlString = response?.url?.absoluteString ?? ""
    logOutput += "URL: \(urlString)\n"
    
    if let httpResponse = response as? HTTPURLResponse {
      logOutput += "Status Code: \(httpResponse.statusCode)\n"
    }
    
    if let error = error {
      logOutput += "Error: \(error.localizedDescription)\n"
    }
    
    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      logOutput += "Response Data: \(json)\n"
    }
    
    logs.append(logOutput)
    print(logOutput)
  }
  
  static func getLogs() -> [String] {
    return logs
  }
  
  static func clearLogs() {
    logs.removeAll()
  }
}
