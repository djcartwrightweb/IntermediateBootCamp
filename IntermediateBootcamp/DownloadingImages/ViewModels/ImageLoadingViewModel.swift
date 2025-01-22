//
//  ImageLoadingViewModel.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-22.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        downloadImage()
    }
    
    func downloadImage() {
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
                self?.image = returnedImage
            }
            .store(in: &cancellables)
            
    }
    
}
