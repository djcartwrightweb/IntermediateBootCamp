//
//  DragGestureView2.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-03.
//

import SwiftUI

struct DragGestureView2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var dragUp: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.linear) {
                    currentDragOffsetY = value.translation.height
                }
            }
            .onEnded { value in
                
                if currentDragOffsetY < -150 {
                    endingOffsetY = -startingOffsetY
                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                    endingOffsetY = 0
                }
                    currentDragOffsetY = 0
            }
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(dragUp)
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureView2()
}

struct MySignUpView: View {
    var body: some View {
        VStack {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favourite swiftui course and I recommend it to all of my friends to learn swiftui.  Subscribe to swiftful thinking now")
                .multilineTextAlignment(.center)
            
            Text("Create an account")
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.black.presentationCornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
