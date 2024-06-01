//
//  HapticFeedbackManager.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 20.05.2024.
//

import UIKit

enum HapticFeedback {
    case light, medium, heavy, soft, rigid
}

final class HapticManager {
    
    static let shared = HapticManager()
    private init() {}
    
    func hapticFeedback(mode: HapticFeedback) {
        
        switch mode {
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
            
        case .rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        }
        
    }
    
    func continuousHapticFeedback(start: Bool) {
        let duration: Double = 4
        let timeInterval: TimeInterval = 0.1
        
        
        DispatchQueue.global().async {
            
            let endTime = Date().addingTimeInterval(duration)
            while Date() < endTime {
                DispatchQueue.main.async {
                    self.hapticFeedback(mode: .rigid)
                }
                Thread.sleep(forTimeInterval: timeInterval)
            }
        }
        
    }
}
