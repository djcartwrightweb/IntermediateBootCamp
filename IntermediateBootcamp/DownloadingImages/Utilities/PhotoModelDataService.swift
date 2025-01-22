//
//  PhotoModelDataService.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-22.
//

import Foundation
import Combine

class PhotoModelDataService {
    static let shared = PhotoModelDataService()
    
    @Published var photoModels: [PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    private init () {
        downloadData()
    }
    
    private func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error downloading data: \(error)")
                }
            } receiveValue: { [weak self] returnedPhotoModels in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellables)

        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
