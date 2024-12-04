//
//  GeometryReaderView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-03.
//

import SwiftUI

struct GeometryReaderView: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geo) * 40), axis:( (x: 0, y: 1, z: 0)))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    
                }
            }
        }
        
        
        //        GeometryReader { geo in
        //            HStack(spacing: 0) {
        //                Rectangle()
        //                    .fill(Color.red)
        //                    .frame(width: geo.size.width * 0.7)
        //                Rectangle()
        //                    .fill(Color.blue)
        //            }
        //            .ignoresSafeArea()
        //        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2 // mid screen
        let currentX = geo.frame(in: .global).midX // mid rectangle
        return Double(1 - (currentX / maxDistance))
    }
}

#Preview {
    GeometryReaderView()
}
