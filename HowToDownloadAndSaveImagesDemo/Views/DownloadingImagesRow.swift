//
//  DownloadingImagesRow.swift
//  HowToDownloadAndSaveImagesDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI

struct DownloadingImagesRow: View {
  let photo: PhotoModel
  
  var body: some View {
    HStack {
      DownloadingImageView(url: photo.url, key: "\(photo.id)")
        .frame(width: 75, height: 75)
      VStack(alignment: .leading) {
        Text(photo.title)
          .font(.headline)
        Text(photo.url)
          .foregroundColor(.gray)
          .italic()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
  static var previews: some View {
    DownloadingImagesRow(photo: PhotoModel(albumId: 1, id: 1, title: "title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
