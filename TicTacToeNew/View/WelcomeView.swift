//
//  WelcomeView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 12.05.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(.purple)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Image("XOXr")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 120)
                        
                    
                    Spacer()
                    
                    VStack(spacing: 50) {
                        
                        Text("Choose your game mode")
                            .padding(.trailing, 80)
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            
                        
                        VStack(spacing: 20) {
                            
                            Button(action: {
                                vm.alternativeMode = false
                                vm.navigate = true
                            }, label: {
                                RoundedButton(text: "Classic", color: .pink)
                            })
                            
                            Button(action: {
                                vm.alternativeMode = true
                                vm.navigate = true
                            }, label: {
                                RoundedButton(text: "Alternative", color: .orange)
                            })
                            
                        }
                    }
                    
                    Spacer()
                }
     
            }
            .navigationDestination(isPresented: $vm.navigate) {
                TicTacToeView()
            }
        }
    }
}



#Preview {
    WelcomeView()
}
