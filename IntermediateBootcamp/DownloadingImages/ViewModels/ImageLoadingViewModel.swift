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
    let manager = PhotoModelCacheManager.shared
//    let manager = PhotoModelFileManager.shared
    let urlString: String
    let imageKey: String
    
    init(urlString: String, imageKey: String) {
        self.urlString = urlString
        self.imageKey = imageKey
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("getting saved imge")
        } else {
            downloadImage()
            print("Downlading image now")
        }
    }
    
    func downloadImage() {
        print("downloading image")
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
//            .tryMap { data, response in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw URLError(.badServerResponse)
//                }
//                print(httpResponse)
//                guard (200...299).contains(httpResponse.statusCode) else {
//                    throw URLError(.badServerResponse)
//                }
//                guard let image = UIImage(data: data) else {
//                    throw URLError(.cannotDecodeContentData)
//                }
//                return image
//            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let image = returnedImage
                else {
                    return
                }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
            
    }
    
}
