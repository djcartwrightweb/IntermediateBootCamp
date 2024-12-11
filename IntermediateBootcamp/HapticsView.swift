//
//  HapticsView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-11.
//

import SwiftUI

class HapticManager {
    static let shared = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsView: View {
    var body: some View {
        
        VStack(spacing: 20) {
            
            Button("Success") {HapticManager.shared.notification(type: .success)}
            Button("Warning") {HapticManager.shared.notification(type: .warning)}
            Button("Error") {HapticManager.shared.notification(type: .error)}
            Divider()
            Button("soft") {HapticManager.shared.impact(style: .soft)}
            Button("light") {HapticManager.shared.impact(style: .light)}
            Button("medium") {HapticManager.shared.impact(style: .medium)}
            Button("rigid") {HapticManager.shared.impact(style: .rigid)}
            Button("heavy") {HapticManager.shared.impact(style: .heavy)}
        }
        
    }
}

#Preview {
    HapticsView()
}
