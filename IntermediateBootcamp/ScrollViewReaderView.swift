//
//  ScrollViewReaderView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-03.
//

import SwiftUI

struct ScrollViewReaderView: View {
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        
        VStack {
            TextField("Enter a number here...", text: $textFieldText)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .padding()
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 10)
                .keyboardType(.numberPad)
            
            Button("Go to \(textFieldText)") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
                
            ScrollView {
                ScrollViewReader { proxy in
                    
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { _, value in
                        withAnimation {
                            proxy.scrollTo(value, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderView()
}
