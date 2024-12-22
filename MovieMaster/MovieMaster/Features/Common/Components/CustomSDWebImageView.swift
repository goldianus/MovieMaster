//
//  CustomSDWebImageView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 07/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomSDWebImageView: View {
  var imgURL: URL?
  var imgWidth: CGFloat?
  var imgHeight: CGFloat?
  var placeholderImage: String?
  var isCircle: Bool
  var cornerRadius: CGFloat = 0
  var body: some View {
    WebImage(url: imgURL) {_ in
      Image(systemName: placeholderImage ?? "person.circle.fill")
        .resizable()
        .foregroundColor(.black)
        .frame(width: imgWidth, height: imgHeight)
        .background(.gray.opacity(0.6))
    }
    .resizable()
    .indicator(.activity)
    .transition(.fade)
    .aspectRatio(contentMode: .fill)
    .frame(width: imgWidth, height: imgHeight)
    .clipped()
    .background(.thinMaterial)
    .cornerRadius(isCircle == true ? imgHeight! / 2 : cornerRadius)
  }
}

#Preview {
  CustomSDWebImageView(isCircle: true)
}
