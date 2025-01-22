//
//  DownloadingImageView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-22.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: ImageLoadingViewModel

    init(urlString: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImageView(urlString: "https://picsum.photos/200")
        .frame(width: 75, height: 75)
}
