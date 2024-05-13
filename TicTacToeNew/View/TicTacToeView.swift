//
//  ContentView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 17.04.2024.
//

import SwiftUI


struct TicTacToeView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        ZStack {
            
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        vm.navigate = false
                        vm.resetGame()
                        
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 40)
                            
                            Image(systemName: "arrowshape.left")
                                .font(.system(size: 18))
                                .foregroundStyle(.cyan)
                                
                        }
                    })
                    
                    Spacer()
                    
                    Text(vm.alternativeMode ? "Alternative" : "Classic")
                        .foregroundStyle(.cyan)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 120, height: 35)
                                .foregroundStyle(.white)
                                
                        )
                        .padding(.trailing, 25)
                    
                    Spacer()
                }
                .padding(.top, 15)
                .padding(.horizontal, 25)
                
                Spacer()
                
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { col in
                            Button(action: {
                                vm.makeMove(row: row, col: col)
                            }, label: {
                                let symbol = vm.board[row][col]?.symbol ?? ""
                                let opacity = vm.board[row][col] == .XwithOpacity || vm.board[row][col] == .OwithOpacity ? 0.4 : 1
                                
                                Text(symbol)
                                    .font(.system(size: 45))
                                    .bold()
                                    .frame(width: 90, height: 90)
                                    .foregroundStyle(vm.board[row][col] == .X || vm.board[row][col] == .XwithOpacity ? .red : .blue)
                                    .opacity(opacity)
                                    .background(Color.black.opacity(0.5))
                                    
                            })
                        }
                    }
                }
                
                if let winner = vm.winner {
                    ResultView(winner: winner)
                        .padding()
                } else {
                    ResultView(winner: vm.winner)
                        .padding()
                }
                
                
                Button(action: {
                    vm.resetGame()
                }, label: {
                    Text("Play Again")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(vm.winnerColor())
                                .frame(width: 130, height: 35)
                        )
                    
                })
                .disabled(vm.winner != nil ? false : true)
                .opacity(vm.winner != nil ? 1 : 0)
                .padding()
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
        
    }
}

struct ResultView: View {
    
    @State var winner: Player?
    
    var body: some View {
    
        TextResult(type: $winner)
        
    }
}

#Preview {
    TicTacToeView()
}
