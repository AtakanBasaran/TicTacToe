//
//  LaucnhView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 14.05.2024.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                
                Image("iconW")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    LaunchView()
}
