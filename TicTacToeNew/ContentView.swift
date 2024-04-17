//
//  ContentView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 17.04.2024.
//

import SwiftUI


struct TicTacToeView: View {
    
    @ObservedObject var game = TicTacToeGame()
    
    var body: some View {
        
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        Button(action: {
                            game.makeMove(row: row, col: col)
                        }, label: {
                            Text(game.board[row][col]?.symbol ?? "")
                                .font(.system(size: 45))
                                .bold()
                                .frame(width: 90, height: 90)
                                .foregroundColor(game.board[row][col] == .X ? .red : .blue)
                                .background(Color.gray.opacity(0.5))
                            
                            
                        })
                    }
                }
            }
            
            Text(game.winner != nil && game.winner != .Draw ? "\(game.winner!.symbol) wins!" : game.board.flatMap({ $0 }).compactMap({ $0 }).count == 9 ? "It's a draw!" : "\(game.currentPlayer.symbol)'s turn")
                .font(.title3)
                .padding()
                .foregroundStyle(Color.white)
                
            
            
            Button(action: {
                game.resetGame()
            }, label: {
                Text("Play Again")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.red)
                            .frame(width: 110, height: 35)
                    )
                
            })
            .disabled(game.winner != nil ? false : true)
            .opacity(game.winner != nil ? 1 : 0)
            
            
        }
        
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}


#Preview {
    TicTacToeView()
}
