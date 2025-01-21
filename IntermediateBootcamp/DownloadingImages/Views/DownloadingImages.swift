//
//  DownloadingImages.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-21.
//

import SwiftUI

struct DownloadingImages: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Hello")
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
