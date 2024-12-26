//
//  NetworkLogView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 26/12/24.
//

import Foundation
import SwiftUI

struct NetworkLogView: View {
  @Environment(\.dismiss) var dismiss
  @State private var logs: [String] = []
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack(alignment: .leading, spacing: 10) {
          ForEach(logs, id: \.self) { log in
            Text(log)
              .font(.system(.body, design: .monospaced))
              .padding()
              .background(Color.gray.opacity(0.2))
              .cornerRadius(8)
          }
        }
        .padding()
      }
      .navigationTitle("Network Logs")
      .navigationBarItems(trailing: Button("Close") {
        dismiss()
      })
    }
    .onAppear {
      logs = NetworkLogger.getLogs()
    }
  }
}
