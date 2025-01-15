//
//  TimerBootcamp.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-15.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    //Current Time
    /*
    @State private var currentDate: Date = Date()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }*/
    
    //Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemaining = "\(minute):\(second)"
    }
    */
    
    //Animation counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.teal.opacity(0.7), Color.blue],
                center: .center,
                startRadius: 5,
                endRadius: 500
            ).ignoresSafeArea()
            
//            Text(timeRemaining)
//                .fontDesign(.monospaced)
//                .fontWeight(.semibold)
//                .font(.system(size: 100))
//                .foregroundStyle(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
//                .padding()
            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundStyle(.white)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.pink)
                    .tag(5)
            }.tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
            
            
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

#Preview {
    TimerBootcamp()
}
