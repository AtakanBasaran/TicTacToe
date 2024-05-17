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
    var gradientCircle = [Color("cyann"), Color("cyann").opacity(0.1), Color("cyann")]
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 220, height: 40)
                .foregroundStyle(color)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 15)
//                        .stroke(
//                            LinearGradient(colors: gradientCircle, startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 2)
//                        )
//                }

            
            Text(text)
                .foregroundStyle(.white)
        }
                
    }
}

#Preview {
    RoundedButton(text: "Classic", color: .pink)
}
