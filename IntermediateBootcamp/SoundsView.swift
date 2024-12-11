//
//  SoundsView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-11.
//

import SwiftUI
import AVKit

class SoundManager {
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada, badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}


struct SoundsView: View {

    

    var body: some View {
        VStack(spacing: 40) {
            
            
            Button("Play sound 1") {
                SoundManager.shared.playSound(sound: .tada)
            }
            
            Button("Play sound 2") {
                SoundManager.shared.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundsView()
}
