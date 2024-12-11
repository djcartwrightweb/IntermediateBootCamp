//
//  HashableView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-11.
//

import SwiftUI

struct MyModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    
    let data: [MyModel] = [
        MyModel(title: "one"),
        MyModel(title: "two"),
        MyModel(title: "three"),
        MyModel(title: "four"),
        MyModel(title: "five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
        .padding()
    }
}

#Preview {
    HashableView()
}
