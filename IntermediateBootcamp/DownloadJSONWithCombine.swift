//
//  DownloadJSONWithCombine.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-15.
//

import SwiftUI
import Combine

struct PostModel2: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadJSONWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel2] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        // 1. sign up for monthly subscription for package to be delievered
        // 2. the company would make the package behind the scenes
        // 3. receive the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use item!!!
        // 7. store it (can be cancelled at any time)
        
        //        URLSession.shared.dataTaskPublisher(for: url) // 1. create the publisher
        //            //.subscribe(on: DispatchQueue.global(qos: .background)) // 2. subscribe publisher on background thread (dataTaskPublisher does this anyway)
        //            .receive(on: DispatchQueue.main) //3. receive on main thread
        //            .tryMap(handleOutput)
        ////            .tryMap { (data, response) -> Data in
        ////                guard
        ////                    let response = response as? HTTPURLResponse,
        ////                    response.statusCode >= 200 && response.statusCode < 300 else {
        ////                    throw URLError(.badServerResponse)
        ////                }
        ////                return data
        ////            } // 4. tryMap - check that the data is good
        //            .decode(type: [PostModel2].self, decoder: JSONDecoder()) //5. decode data into Models
        //            .sink { completion in
        //                print(completion)
        //            } receiveValue: { [weak self] returnedPosts in
        //                    self?.posts = returnedPosts
        //            } // 6. sink puts the item into our app
        //            .store(in: &cancellables) // 7. store the item
        //    }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel2].self, decoder: JSONDecoder())
            .replaceError(with: []) //can remove the completion from the sink and just used the received value
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    //handle errors
                    print(error)
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadJSONWithCombine: View {
    
    @StateObject var vm = DownloadJSONWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    DownloadJSONWithCombine()
}
