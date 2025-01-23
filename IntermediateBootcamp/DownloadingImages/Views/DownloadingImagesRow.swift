//
//  DownloadingImagesRow.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-22.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(urlString: model.url, imageKey: "\(model.id)")
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

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "my Title", url: "https://picsum.photos/200", thumbnailUrl: "https://picsum.photos/200"))
        .padding()
}
