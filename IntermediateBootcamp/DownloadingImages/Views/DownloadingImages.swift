//
//  DownloadingImages.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-21.
//

import SwiftUI

struct DownloadingImages: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            . listStyle(.inset)
            .listItemTint(.cyan)
            .navigationTitle("Downloading Images!")
        }
    }
}

#Preview {
    DownloadingImages()
}
