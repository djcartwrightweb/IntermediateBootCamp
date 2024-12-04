//
//  DragGestureView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-03.
//

import SwiftUI

struct DragGestureView: View {
    @State private var isDragging = false
    @State private var offset: CGSize = .zero

    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.spring()) {
                    offset = value.translation
                }
                self.isDragging = true
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    offset = .zero
                }
                self.isDragging = false
            }
    }

//left off at 14:33 of continued learning #4
    
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(self.isDragging ? Color.red : Color.blue)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(drag)
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let maxAngle: Double = 10
        return Double(percentage) * maxAngle
    }
    
}

#Preview {
    DragGestureView()
}
