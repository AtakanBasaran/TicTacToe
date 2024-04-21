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
        
        VStack {
            
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        Button(action: {
                            vm.makeMove(row: row, col: col)
                        }, label: {
                            Text(vm.board[row][col]?.symbol ?? "")
                                .font(.system(size: 45))
                                .bold()
                                .frame(width: 90, height: 90)
                                .foregroundColor(vm.board[row][col] == .X ? .red : .blue)
                                .background(Color.gray.opacity(0.5))
                            
                            
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
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.green)
                            .frame(width: 110, height: 35)
                    )
                
            })
            .disabled(vm.winner != nil ? false : true)
            .opacity(vm.winner != nil ? 1 : 0)
            .padding()
            
            
        }
        
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
