//
//  LongPressGesture.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-02.
//

import SwiftUI

struct LongPressGesture: View {
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    var body: some View {

        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK ME")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isComplete = true
                                
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }

                            
                Text("RESET")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
                
            }
                
        
            
        }
        
        
        //        Text(isComplete ? "complete" : "not complete")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray.opacity(0.2))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 300.0) {
//                isComplete.toggle()
//            }
    }
}

#Preview {
    LongPressGesture()
}
