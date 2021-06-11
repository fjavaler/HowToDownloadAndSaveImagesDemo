//
//  ContentViewModel.swift
//  HowToDownloadAndSaveImagesDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
  // MARK: Properties
  @Published var dataArray: [PhotoModel] = []
  let dataService = PhotoModelDataService.instance
  var cancellables = Set<AnyCancellable>()
  
  // MARK: Init
  init() {
    addSubscribers()
  }
  
  // MARK: Methods
  func addSubscribers() {
    dataService.$photoModels
      .sink { [weak self] returnedPhotoModels in
        self?.dataArray = returnedPhotoModels
      }
      .store(in: &cancellables)
  }
  
}
