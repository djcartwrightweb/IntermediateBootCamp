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
                    HStack {
                        Circle()
                            .frame(width: 75, height: 75)
                        VStack(alignment: .leading) {
                            Text(model.title)
                                .font(.headline)
                            Text(model.url)
                                .foregroundStyle(.gray)
                                .italic()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
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
