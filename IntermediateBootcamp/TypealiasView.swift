//
//  TypealiasView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-14.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasView: View {
    
    @State var item: MovieModel = MovieModel(
        title: "Title",
        director: "Joe",
        count: 5
    )
    
    @State var item2: TVModel = TVModel(
        title: "TV Title",
        director: "Emily",
        count: 5
    )
    
    var body: some View {
        Text(item.title)
        Text(item.director)
        Text("\(item.count)")
    }
}

#Preview {
    TypealiasView()
}
