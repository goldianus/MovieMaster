//
//  HomeView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import SwiftUI


struct HomeView: View {
  @StateObject private var viewModel = MoviesViewModel()
  
  var body: some View {
    NavigationView {
      Group {
        if viewModel.isLoading {
          //          Text("Progress View")
        } else {
          Text("Content View")
        }
      }
      .navigationTitle("Now Playing")
      .alert("Error", isPresented: Binding(
        get: { viewModel.error != nil },
        set: { if !$0 { viewModel.error = nil } }
      )) {
        Text(viewModel.error?.localizedDescription ?? "")
      }
    }
    .onAppear {
      viewModel.fetchNowPlaying()
    }
  }
}

#Preview {
  HomeView()
}
