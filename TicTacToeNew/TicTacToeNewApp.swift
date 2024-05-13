//
//  TicTacToeNewApp.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 17.04.2024.
//

import SwiftUI

@main
struct TicTacToeNewApp: App {
    
    @StateObject var viewVM = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .preferredColorScheme(.dark)
                .environmentObject(viewVM)
            
        }
    }
}
