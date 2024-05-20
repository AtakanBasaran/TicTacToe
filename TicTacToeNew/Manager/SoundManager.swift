//
//  SoundManager.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 20.05.2024.
//

import Foundation
import AVFoundation

final class SoundManager {
    
    static let shared = SoundManager()
    
    private init() {}
    
    private var player: AVAudioPlayer?

    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "shortSound", withExtension: ".mp3") else {
            print("Sound file is not found")
            return
        }
        
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            
        } catch {
            print("Error playing sound")
            print(error.localizedDescription)
        }
        
        
    }
}
