//
//  ImageLoadingViewModel.swift
//  HowToDownloadAndSaveImagesDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
  
  @Published var image: UIImage? = nil
  @Published var isLoading: Bool = false
  let urlString: String
  let imageKey: String
  var cancellables = Set<AnyCancellable>()
  // TODO: Switch between PhotoModelFileManager.instance and PhotoModelCacheManager to compare RAM usage.
  let manager = PhotoModelFileManager.instance
  
  init(url: String, key: String) {
    urlString = url
    imageKey = key
    getImage()
  }
  
  func getImage() {
    if let savedImage = manager.get(key: imageKey) {
      image = savedImage
      print("Getting cached image!")
    } else {
      downloadImage()
      print("Downloading image now!")
    }
  }
  
  func downloadImage() {
    print("Downloading image now!")
    isLoading = true
    
    guard let url = URL(string: urlString) else {
      isLoading = false
      return
    }
    
    URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: { [weak self] returnedImage in
        guard let self = self,
              let image = returnedImage else {
          return
        }
        
        self.image = image
        self.manager.add(key: self.imageKey, value: image)
      }
      .store(in: &cancellables)

  }
}
