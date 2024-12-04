//
//  MagnificationGesture.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-02.
//

import SwiftUI

//struct MagnificationGestureView: View {
//
//    @GestureState private var magnifyBy = 1.0
//
//    @State private var currentZoom = 0.0
//    @State private var totalZoom = 1.0
//
//    var magnification: some Gesture {
//        MagnifyGesture()
////        .updating($magnifyBy) { value, gestureState, transaction in
////                gestureState = value.magnification
////            }
//            .onChanged { value in
//                currentZoom = value.magnification - 1
//            }
//            .onEnded { value in
//                totalZoom += currentZoom
//                currentZoom = 0
//            }
//    }
//
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(40)
//            .background(Color.red)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .scaleEffect(currentZoom + totalZoom)
//            .gesture(magnification)
//            .accessibilityZoomAction { action in
//                if action.direction == .zoomIn {
//                    totalZoom += 1
//                } else {
//                    totalZoom -= 1
//                }
//            }
//    }
//}

struct MagnificationGestureView: View {
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var magnification: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                currentZoom = value.magnification - 1
            }
            .onEnded { value in
                currentZoom = 0
            }
    }
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                    .padding(.trailing)
                Text("Davey")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentZoom)
                .gesture(magnification)
//                .accessibilityZoomAction { action in
//                    if action.direction == .zoomIn {
//                        totalZoom += 1
//                    } else {
//                        totalZoom -= 1
//                    }
//                }
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .font(.headline)
            .padding(.horizontal)
            Text("This is the caption")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}

#Preview {
    MagnificationGestureView()
}
