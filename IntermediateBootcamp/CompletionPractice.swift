//
//  CompletionPractice.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-15.
//

import SwiftUI

struct Comment: Identifiable, Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

final class CompletionPracticeViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    
    init() {
        getData { [weak self] result in
            print(result)
            
            DispatchQueue.main.async {
                self?.comments.append(contentsOf: result)
            }
        }
    }
    
    private func getData(completion: @escaping ([Comment]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments/")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                return
            }
            guard let decodedData = try? JSONDecoder().decode([Comment].self, from: data) else {return}
            completion(decodedData)
        }
        .resume()
    }
    
}


struct CompletionPractice: View {
    
    
    @StateObject private var vm = CompletionPracticeViewModel()
    
    var body: some View {
        List {
            ForEach(vm.comments) {
                Text($0.name)
            }
        }
    }
}

#Preview {
    CompletionPractice()
}
