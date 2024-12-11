//
//  MaskView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-10.
//

import SwiftUI

struct MaskView: View {
    
    @State var rating: Int = 2
    
    var body: some View {
        ZStack {
            StarsView
                .overlay {
                    OverlayView
                        .mask(StarsView)
                }
        }
    }
    
    private var OverlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundStyle(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false) //without, unable to tap as tapping on overlayview and not starsview
    }
    
    private var StarsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
            
        }
    }
    
}

#Preview {
    MaskView()
}
