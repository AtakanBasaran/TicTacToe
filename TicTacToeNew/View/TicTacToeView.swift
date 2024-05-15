//
//  ContentView.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 17.04.2024.
//

import SwiftUI


struct TicTacToeView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State private var xScore = 0
    @State private var oScore = 0
    
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
                    .padding(.leading, 25)
                    
                    Spacer()
                    
                    Text(vm.alternativeMode ? "Alternative" : "Classic")
                        .foregroundStyle(.cyan)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 120, height: 35)
                                .foregroundStyle(.white)
                            
                        )
                        .padding(.trailing, 65)
                    
                    Spacer()
                }
                .padding(.top, 15)
                
                
                Spacer()
                
                HStack(spacing: 50) {
                    
                    HStack {
                        
                        Text("X")
                            .font(.system(size: 22))
                            .foregroundColor(.red)
                            .bold()
                        
                        Image(systemName: "minus")
                            .foregroundStyle(.white)
                        
                        
                        Text("\(xScore)")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                    
                    HStack {
                        
                        Text("O")
                            .font(.system(size: 22))
                            .foregroundColor(.blue)
                            .bold()
                        
                        
                        Image(systemName: "minus")
                            .foregroundStyle(.white)
                        
                        Text("\(oScore)")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                }
                .padding(.bottom, 15)
                
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
                        .padding(.bottom, 35)
                } else {
                    ResultView(winner: vm.winner)
                        .padding()
                        .padding(.bottom, 35)
                }
                
                
                
                if vm.winner != nil {
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
                    .padding()
                } else {
                    Button(action: {
                        vm.resetGame()
                    }, label: {
                        Text("Restart")
                            .foregroundStyle(.cyan)
                            .font(.title3)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.white)
                                    .frame(width: 130, height: 35)
                            )
                        
                    })
                    .padding()
                }
                
                
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: vm.winner) { value in
            
            if value == .O || value == .OwithOpacity  {
                self.oScore += 1


            } else if value == .X || value == .XwithOpacity {
                self.xScore += 1
        
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if value.translation.width > 50 {
                        vm.navigate = false
                        vm.resetGame()
                    }
                })
        )
        
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
