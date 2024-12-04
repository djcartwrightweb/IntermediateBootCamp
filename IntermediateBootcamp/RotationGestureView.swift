//
//  RotationGestureView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-02.
//

import SwiftUI

struct RotationGestureView: View {
    @State private var angle = Angle(degrees: 0.0)
    
    var body: some View {
        Text("Hello Word")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        angle = value.rotation
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0.0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureView()
}
