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
    @Published var alternativeMode = false
    @Published var navigate = false
    @Published var playerMoves: [Player : [(row: Int, col: Int)] ] = [.X: [], .O:[] ]
    
    private var timer: Timer?

    
    
    func makeMove(row: Int, col: Int) {
        
        guard board[row][col] == nil && winner == nil else { return }
        
        playerMoves[currentPlayer]?.append((row, col))
        board[row][col] = currentPlayer
        
        
        
        if alternativeMode {
            
            if currentPlayer == .X {
                
                if var moves = playerMoves[.O] {
                    
                    if moves.count == 3  {
                        
                        if let firstMove = moves.first {
                            board[firstMove.row][firstMove.col] = board[firstMove.row][firstMove.col] == .O ? .OwithOpacity : .OwithOpacity
                        } else {
                            print("not fainted")
                        }
                        
                    } /*else if moves.count == 4 {*/
//                        
//                        if let firstMove = moves.first {
//                            moves.removeFirst()
//                            playerMoves[currentPlayer] = moves
//                            board[firstMove.row][firstMove.col] = nil
//                            
////                            if let firstMove2 = moves.first {
////                                board[firstMove2.row][firstMove2.col] = board[firstMove.row][firstMove.col] == .O ? .OwithOpacity : .OwithOpacity
////                            }
//              
//                        }
//                    }
                    
                }
            } else if currentPlayer == .O {
                
                if var moves = playerMoves[.X] {
                    
                    if moves.count == 3  {
                        
                        if let firstMove = moves.first {
                            board[firstMove.row][firstMove.col] = board[firstMove.row][firstMove.col] == .X ? .XwithOpacity : .XwithOpacity
                        } else {
                            print("not fainted")
                        }
                        
                    } /*else if moves.count == 4 {*/
//                        
//                        if let firstMove = moves.first {
//                            moves.removeFirst()
//                            playerMoves[currentPlayer] = moves
//                            board[firstMove.row][firstMove.col] = nil
//                            
////                            if let firstMove2 = moves.first {
////                                board[firstMove2.row][firstMove2.col] = board[firstMove.row][firstMove.col] == .O ? .OwithOpacity : .OwithOpacity
////                            }
//              
//                        }
//                    }
                    
                }
            }
            
            if var moves = playerMoves[currentPlayer] {
                
                if moves.count == 4 {
                    
                    if let firstMove = moves.first {
                        moves.removeFirst()
                        playerMoves[currentPlayer] = moves
                        board[firstMove.row][firstMove.col] = nil
                        
//                        if let firstMove2 = moves.first {
//                            board[firstMove2.row][firstMove2.col] = board[firstMove.row][firstMove.col] == .O ? .OwithOpacity : .OwithOpacity
//                        }
          
                    }
                }
            }
        }
        checkForWinner()
        
        if winner == nil {
            currentPlayer = currentPlayer == .X ? .O : .X
        }
   
    }
    

    private func checkForWinner() {
        
        // Check rows, columns, and diagonals
        for _ in 0..<3 {
            
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
                    
                    if winner == .O || winner == .OwithOpacity {
                        
                        self.board[i][0] = .O
                        self.board[i][1] = .O
                        self.board[i][2] = .O
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                withAnimation {
                                    
                                    self.board[i][0] = .O
                                    self.board[i][1] = .O
                                    self.board[i][2] = .O
                                    
                                    withAnimation(.smooth.delay(0.5)) {
                                        self.board[i][0] = .OwithOpacity
                                        self.board[i][1] = .OwithOpacity
                                        self.board[i][2] = .OwithOpacity
                                    }
                                }
                            }
                            self.timer?.fire()
                        }
                        
                    } else if winner == .X || winner == .XwithOpacity {
                        
                        self.board[i][0] = .X
                        self.board[i][1] = .X
                        self.board[i][2] = .X
                        
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            withAnimation {
                                
                                self.board[i][0] = .X
                                self.board[i][1] = .X
                                self.board[i][2] = .X
                                
                                withAnimation(.smooth.delay(0.5)) {
                                    self.board[i][0] = .XwithOpacity
                                    self.board[i][1] = .XwithOpacity
                                    self.board[i][2] = .XwithOpacity
                                }
                            }
                        }
                        timer?.fire()
                        
                    }
                    
                    return
                }
                
                
                if symbolsAreEqual(board[0][i], board[1][i]) && symbolsAreEqual(board[0][i], board[2][i]) {
                    winner = board[0][i]
                    
                    if winner == .O || winner == .OwithOpacity {
                        
                        self.board[0][i] = .O
                        self.board[1][i] = .O
                        self.board[2][i] = .O
                        
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            withAnimation {
                                
                                self.board[0][i] = .O
                                self.board[1][i] = .O
                                self.board[2][i] = .O
                                
                                withAnimation(.smooth.delay(0.5)) {
                                    self.board[0][i] = .OwithOpacity
                                    self.board[1][i] = .OwithOpacity
                                    self.board[2][i] = .OwithOpacity
                                }
                            }
                        }
                        timer?.fire()
                        
                    } else if winner == .X || winner == .XwithOpacity {
                        
                        self.board[0][i] = .X
                        self.board[1][i] = .X
                        self.board[2][i] = .X
                        
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            withAnimation {
                                
                                self.board[0][i] = .X
                                self.board[1][i] = .X
                                self.board[2][i] = .X
                                
                                withAnimation(.smooth.delay(0.5)) {
                                    self.board[0][i] = .XwithOpacity
                                    self.board[1][i] = .XwithOpacity
                                    self.board[2][i] = .XwithOpacity
                                }
                            }
                        }
                        timer?.fire()
                    }
                    return
                }
                
            }
            
            if symbolsAreEqual(board[0][0], board[1][1]) && symbolsAreEqual(board[0][0], board[2][2]) {
                winner = board[0][0]
                
                if winner == .O || winner == .OwithOpacity {
                    
                    self.board[0][0] = .O
                    self.board[1][1] = .O
                    self.board[2][2] = .O
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        withAnimation {
                            
                            self.board[0][0] = .O
                            self.board[1][1] = .O
                            self.board[2][2] = .O
                            
                            withAnimation(.smooth.delay(0.5)) {
                                self.board[0][0] = .OwithOpacity
                                self.board[1][1] = .OwithOpacity
                                self.board[2][2] = .OwithOpacity
                            }
                        }
                    }
                    timer?.fire()
                    
                } else if winner == .X || winner == .XwithOpacity {
                    
                    self.board[0][0] = .X
                    self.board[1][1] = .X
                    self.board[2][2] = .X
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        withAnimation {
                            
                            self.board[0][0] = .X
                            self.board[1][1] = .X
                            self.board[2][2] = .X
                            
                            withAnimation(.smooth.delay(0.5)) {
                                self.board[0][0] = .XwithOpacity
                                self.board[1][1] = .XwithOpacity
                                self.board[2][2] = .XwithOpacity
                            }
                        }
                    }
                    timer?.fire()
                }
                
                return
            }
            
            if symbolsAreEqual(board[0][2], board[1][1]) && symbolsAreEqual(board[0][2], board[2][0]) {
                winner = board[0][2]
                
                if winner == .O || winner == .OwithOpacity {
                    
                    self.board[0][2] = .O
                    self.board[1][1] = .O
                    self.board[2][0] = .O
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        withAnimation {
                            
                            self.board[0][2] = .O
                            self.board[1][1] = .O
                            self.board[2][0] = .O
                            
                            withAnimation(.smooth.delay(0.5)) {
                                self.board[0][2] = .OwithOpacity
                                self.board[1][1] = .OwithOpacity
                                self.board[2][0] = .OwithOpacity
                            }
                        }
                    }
                    timer?.fire()
                    
                } else if winner == .X || winner == .XwithOpacity {
                    
                    self.board[0][2] = .X
                    self.board[1][1] = .X
                    self.board[2][0] = .X
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        withAnimation {
                            
                            self.board[0][2] = .X
                            self.board[1][1] = .X
                            self.board[2][0] = .X
                            
                            withAnimation(.smooth.delay(0.5)) {
                                self.board[0][2] = .XwithOpacity
                                self.board[1][1] = .XwithOpacity
                                self.board[2][0] = .XwithOpacity
                            }
                        }
                    }
                    timer?.fire()
                }
                
                return
            }
            
            // Check for draw
            if board.flatMap({ $0 }).compactMap({ $0 }).count == 9 && winner != .X && winner != .O && winner == nil {
                winner = .Draw
            }
        }
    }
    
    func resetGame() {
        winner = nil
        timer?.invalidate()
        timer = nil
        board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
        playerMoves = [.X: [], .O:[] ]
        currentPlayer = .X
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
