//
//  CarouselCardView.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 07/11/24.
//

import SwiftUI

struct CarouselCardView: View {
  var movie: Movie

  var body: some View {
    VStack(alignment: .center) {
      popularImageView()
    }
    .frame(width: 200, height: 260)
    .background(.white)
    .cornerRadius(10)
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
  }
  
  @ViewBuilder
  func popularImageView() -> some View {
    let imgUrl = URL(string: "\(imagePath)" + "\(movie.posterPath )")
    CustomSDWebImageView(imgURL: imgUrl,
                         imgWidth: 200,
                         imgHeight: 260,
                         placeholderImage: "StringConstants.placeholderImageFilm",
                         isCircle: false)
  }
}

#Preview {
    CarouselCardView( movie: Movie(
      id: 1,
      title: "",
      overview: "",
      posterPath: "StringConstants.placeholderImageFilm",
      backdropPath: "",
      releaseDate: "",
      voteAverage: 1
    ))
}
