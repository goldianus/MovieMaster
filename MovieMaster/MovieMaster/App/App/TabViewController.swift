//
//  TabViewController.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 04/11/24.
//

import SwiftUI
import Foundation

struct TabViewController: View {
  @State private var showNetworkLogs = false
  
  var body: some View {
    TabView {
      HomeView()
        .onShake {
          showNetworkLogs = true
        }
        .sheet(isPresented: $showNetworkLogs) {
          NetworkLogView()
        }
      
        .tabItem {
          Label("Home", systemImage: "house.circle.fill")
        }
      
      ExploreView()
        .tabItem {
          Label("Explore", systemImage: "bell.circle.fill")
        }
    }
    .onAppear {
      let appearance = UITabBarAppearance()
      appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
      appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
      UITabBar.appearance().standardAppearance = appearance
      UITabBar.appearance().scrollEdgeAppearance = appearance
    }
  }
}
