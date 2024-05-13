//
//  ViewModel.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 17.04.2024.
//

import SwiftUI

enum Player {
    case X
    case O
    case Draw
    case XwithOpacity
    case OwithOpacity
    
    var symbol: String {
        
        switch self {
            
        case .X, .XwithOpacity: return "X"
        case .O, .OwithOpacity: return "O"
        case .Draw: return ""
            
        }
    }
}


class ViewModel: ObservableObject {
    
    @Published private(set) var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @Published private(set) var currentPlayer: Player = .X
    @Published private(set) var winner: Player? = nil
    @Published var turnMessage: Text?
    @Published var alternativeMode = false
    @Published var navigate = false
    
    private var moveCountX = 0
    private var moveCountO = 0
    private var playerMoves: [Player : [(row: Int, col: Int)] ] = [.X: [], .O:[] ]
    
    
    
    func makeMove(row: Int, col: Int) {
        
        guard board[row][col] == nil && winner == nil else { return }
        
        playerMoves[currentPlayer]?.append((row, col))
        board[row][col] = currentPlayer
        
        
        if alternativeMode {
            
            if var moves = playerMoves[currentPlayer] {
                
                if moves.count == 3 {
                    if let firstMove = moves.first {
                        board[firstMove.row][firstMove.col] = currentPlayer == .X ? .XwithOpacity : .OwithOpacity
  
                    } else {
                        print("not fainted")
                    }
                    
                } else if moves.count == 4 {
                    if let firstMove = moves.first {
                        moves.removeFirst()
                        playerMoves[currentPlayer] = moves
                        board[firstMove.row][firstMove.col] = nil
                        
                        if let firstMove2 = moves.first {
                            board[firstMove2.row][firstMove2.col] = currentPlayer == .X ? .XwithOpacity : .OwithOpacity
                        }

                    }
                }
            }
        }

        currentPlayer = currentPlayer == .X ? .O : .X
        
        checkForWinner()
    }
    

    private func checkForWinner() {
        
        // Check rows, columns, and diagonals
        for i in 0..<3 {
            
            func symbolsAreEqual(_ symbol1: Player?, _ symbol2: Player?) -> Bool {
                // Consider regular symbols and symbols with opacity as equal
                return symbol1 == symbol2 ||
                (symbol1 == .X && symbol2 == .XwithOpacity) ||
                (symbol1 == .XwithOpacity && symbol2 == .X) ||
                (symbol1 == .O && symbol2 == .OwithOpacity) ||
                (symbol1 == .OwithOpacity && symbol2 == .O)
            }
            
            // Check rows, columns, and diagonals
            for i in 0..<3 {
                if symbolsAreEqual(board[i][0], board[i][1]) && symbolsAreEqual(board[i][0], board[i][2]) {
                    winner = board[i][0]
                    return
                }
                if symbolsAreEqual(board[0][i], board[1][i]) && symbolsAreEqual(board[0][i], board[2][i]) {
                    winner = board[0][i]
                    return
                }
            }
            if symbolsAreEqual(board[0][0], board[1][1]) && symbolsAreEqual(board[0][0], board[2][2]) {
                winner = board[0][0]
                return
            }
            if symbolsAreEqual(board[0][2], board[1][1]) && symbolsAreEqual(board[0][2], board[2][0]) {
                winner = board[0][2]
                return
            }
            
            // Check for draw
            if board.flatMap({ $0 }).compactMap({ $0 }).count == 9 && winner != .X && winner != .O && winner == nil {
                winner = .Draw // if there is no winner, it's a draw
            }
        }
    }
        
        func resetGame() {
            board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
            playerMoves = [.X: [], .O:[] ]
            currentPlayer = .X
            winner = nil
        }
        
        func winnerColor() -> Color {
            
            switch winner {
                
            case .Draw:
                return .green
            case .O:
                return .blue
                
            case .X:
                return .red
                
            case .XwithOpacity:
                return .red
                
            case .OwithOpacity:
                return .blue
                
            case .none:
                return .gray
            }
        }
        
    
    
}
