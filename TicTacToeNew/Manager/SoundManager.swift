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
    
    var randomSound: String {
        let sounds = ["shorted","shorted2","shorted3","shorted4","shorted5","shorted6","shorted7","shorted8"]
        return sounds.randomElement() ?? "shorted"
    }

    
    func playSound(sound: String) {
        
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else {
            print("Sound file is not found")
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                
                DispatchQueue.main.async {
                    self?.player = audioPlayer
                    self?.player?.play()
                }
                
            } catch {
                print("Error playing sound")
                print(error.localizedDescription)
            }
        }
    }
}
