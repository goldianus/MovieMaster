//
//  TabViewController.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 04/11/24.
//

import SwiftUI

enum TabItem: Int {
  case home, notification
}

struct TabViewController: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house.circle.fill")
        }
      
      HomeView()
        .tabItem {
          Label("Notification", systemImage: "bell.circle.fill")
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
