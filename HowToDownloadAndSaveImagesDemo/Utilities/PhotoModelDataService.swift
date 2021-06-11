//
//  PhotoModelDataService.swift
//  HowToDownloadAndSaveImagesDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import Foundation
import Combine

class PhotoModelDataService {
  
  // MARK: Properties
  static let instance = PhotoModelDataService() // Singleton instance
  @Published var photoModels: [PhotoModel] = []
  var cancellables = Set<AnyCancellable>()
  
  // MARK: Init
  private init() {
    downloadData()
  }
  
  // MARK: Methods
  func downloadData() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
    
    URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .tryMap(handleOutput)
      .decode(type: [PhotoModel].self, decoder: JSONDecoder())
      .sink { completionHandler in
        switch completionHandler {
        case .finished:
          break
        case .failure(let error):
          print("Error downloading data. \(error)")
        }
      } receiveValue: { [weak self] returnedPhotoModels in
        self?.photoModels = returnedPhotoModels
      }
      .store(in: &cancellables)
  }
  
  private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      throw URLError(.badServerResponse)
    }
    return output.data
  }
}
