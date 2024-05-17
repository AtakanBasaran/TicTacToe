//
//  WelcomeView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 12.05.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State private var launch = true
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.cyan
                    .ignoresSafeArea()
                
                VStack {
                    
                    Image("xox2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 120)
                        .padding(.top, 10)
                        
                    
                    Spacer()
                    
                    VStack(spacing: 100) {
                        
                        Image("xoxla")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(.rect(cornerRadius: 15))
                            .frame(width: 220, height: 220)
                            
                            
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Mode")
                                .foregroundStyle(.gray)
                            
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
                    .padding(.bottom, 80)
                    
                    Spacer()
                }
                
                if launch {
                    
                    LaunchView()
                }
     
            }
            .navigationDestination(isPresented: $vm.navigate) {
                TicTacToeView()
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut) {
                        self.launch = false
                    }
                }
            })
        }
    }
}



#Preview {
    WelcomeView()
}
