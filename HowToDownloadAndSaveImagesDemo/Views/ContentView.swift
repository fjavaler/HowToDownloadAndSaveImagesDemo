//
//  ContentView.swift
//  HowToDownloadAndSaveImagesDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI

struct ContentView: View {
  // MARK: Properties
  @StateObject var vm = ContentViewModel()
  
  // MARK: Body
  var body: some View {
    NavigationView {
      List {
        ForEach(vm.dataArray) { photo in
          DownloadingImagesRow(photo: photo)
        }
      }
      .navigationTitle("Downloading Images!")
    }
  }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
