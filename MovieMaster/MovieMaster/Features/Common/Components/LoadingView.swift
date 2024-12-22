//
//  LoadingView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 04/11/24.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    HStack {
      ActivityIndicatorView(color: .blue, size: 30)
    }
    .padding()
  }
}

// MARK: - Activity Indicator View
struct ActivityIndicatorView: View {
  @State private var isAnimating = false
  let color: Color
  let size: CGFloat
  
  init(color: Color = .blue, size: CGFloat = 50) {
    self.color = color
    self.size = size
  }
  
  var body: some View {
    GeometryReader { geometry in
      ForEach(0..<8) { index in
        Group {
          Circle()
            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
            .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
            .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
        .animation(
          Animation
            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
            .repeatForever(autoreverses: false),
          value: isAnimating
        )
      }
    }
    .frame(width: size, height: size)
    .foregroundColor(color)
    .onAppear {
      self.isAnimating = true
    }
  }
}
