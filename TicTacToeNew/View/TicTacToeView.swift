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
            
            Color.purple
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        vm.resetGame()
                        vm.navigate = false
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 30)
                            
                            Image(systemName: "arrowshape.left")
                                
                        }
                    })
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                
                Spacer()
                
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
                                    .foregroundStyle(vm.board[row][col] == .X ? .red : .blue)
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
                                .foregroundStyle(.green)
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
