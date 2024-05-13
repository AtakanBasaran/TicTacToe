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
    
    var symbol: String {
        
        switch self {
            
        case .X: return "X"
        case .O: return "O"
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
            
            if let moves = playerMoves[currentPlayer], moves.count == 4 {
                
                if let firstMove = moves.first {
                    
                    board[firstMove.row][firstMove.col] = nil
                    playerMoves[currentPlayer]?.removeFirst()
                }
            }
        }

        currentPlayer = currentPlayer == .X ? .O : .X
        
        checkForWinner()
    }
    
    func removeFirst(for player: Player) {
        
        for i in 0..<3 {
            
            for j in 0..<3 {
                if board[i][j] == player {
                    board[i][j] = nil
                    return
                }
            }
        }
    }
    
    
    
    
    private func checkForWinner() {
        
        // Check rows, columns, and diagonals
        for i in 0..<3 {
            if board[i][0] != nil && board[i][0] == board[i][1] && board[i][0] == board[i][2] {
                winner = board[i][0]
                return
            }
            if board[0][i] != nil && board[0][i] == board[1][i] && board[0][i] == board[2][i] {
                winner = board[0][i]
                return
            }
        }
        if board[0][0] != nil && board[0][0] == board[1][1] && board[0][0] == board[2][2] {
            winner = board[0][0]
            return
        }
        if board[0][2] != nil && board[0][2] == board[1][1] && board[0][2] == board[2][0] {
            winner = board[0][2]
            return
        }
        
        // Check for draw
        if board.flatMap({ $0 }).compactMap({ $0 }).count == 9 && winner != .X && winner != .O && winner == nil {
            winner = .Draw // if there is no winner, it's a draw
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
            
        case .none:
            return .gray
        }
    }
    
    
    
}
