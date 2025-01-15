//
//  DownloadJSONWithEscaping.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-15.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadJSONWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else {return}
        
        downloadData(from: url) { data in
            if let data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts.append(contentsOf: newPosts)
                }
            } else {
                print("No data returned")
            }
        }
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            guard
//                let data = data,
//                error == nil,
//                let response = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Something went wrong...")
//                return
//            }
            
//            guard let data = data else {
//                print("no data")
//                return
//            }
//            guard error == nil else {
//                print("Error: \(String(describing: error))")
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Invalid response.")
//                return
//            }
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Status code is invalid - it is \(response.statusCode)")
//                return
//            }
//            
//            print("Successfully downloaded data:")
//            
//            guard let newPost: PostModel = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
//            
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
//            }
//            
//        }.resume()
    }
    
    func downloadData(from url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Something went wrong...")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }.resume()
    }
    
}

struct DownloadJSONWithEscaping: View {
    
    @StateObject private var vm = DownloadJSONWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {
                
                Text($0.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text($0.body)
                
            }
        }
        .listStyle(.inset)
    }
}
    
    #Preview {
        DownloadJSONWithEscaping()
            .preferredColorScheme(.dark)
    }
