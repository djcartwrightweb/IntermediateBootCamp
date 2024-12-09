//
//  MultipleSheetsView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-03.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    
    let title: String
}



struct MultipleSheetsView: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
                
                
                
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsView()
}
