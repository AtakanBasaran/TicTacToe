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
    var timer: DispatchSourceTimer?

    
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
    
    func startContinuousHapticFeedback(duration: Double = 3, timeInterval: TimeInterval = 0.1) {
        
        stopContinuousHaptic()
        
        let endTime = Date().addingTimeInterval(duration)
        
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.schedule(deadline: .now(), repeating: timeInterval)
        
        timer?.setEventHandler { [weak self] in
            
            guard let self = self else {return}
            
            if Date() >= endTime {
                stopContinuousHaptic()
            } else {
                hapticFeedback(mode: .rigid)
            }
        }
        
        timer?.resume()
    }
    
    func stopContinuousHaptic() {
        timer?.cancel()
        timer = nil
    }
    
//    func continuousHapticFeedback() {
//        let duration: Double = 4
//        let timeInterval: TimeInterval = 0.1
//        
//        
//        DispatchQueue.global().async {
//            
//            let endTime = Date().addingTimeInterval(duration)
//            while Date() < endTime {
//                DispatchQueue.main.async {
//                    self.hapticFeedback(mode: .rigid)
//                }
//                if !self.runningHaptic {
//                    return
//                }
//                Thread.sleep(forTimeInterval: timeInterval)
//            }
//        }
//        
//    }
}
