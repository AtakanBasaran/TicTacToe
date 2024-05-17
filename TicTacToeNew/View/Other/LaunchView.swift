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
                
                Image("xoxla")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 230, alignment: .center)
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    LaunchView()
}
