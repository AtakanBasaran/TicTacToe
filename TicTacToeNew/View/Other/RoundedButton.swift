//
//  RoundedButton.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 12.05.2024.
//

import SwiftUI

struct RoundedButton: View {
    
    let text: String
    let color: Color
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 220, height: 40)
                .foregroundStyle(color)
            
            Text(text)
                .foregroundStyle(.white)
                
        }
    }
}

#Preview {
    RoundedButton(text: "Classic", color: .pink)
}
