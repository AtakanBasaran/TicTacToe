//
//  TextResult.swift
//  TicTacToeNew
//
//  Created by Atakan Başaran on 20.04.2024.
//

import SwiftUI

struct TextResult: View {
    
    @EnvironmentObject var vm: ViewModel
    @Binding var type: Player?
    
    
    var body: some View {
        
        VStack {
            resultText
        }
    }
    
    @ViewBuilder private var resultText: some View {
        
        if let type {
            
            if type == .O  {
                
                viewO
                
            } else if type == .X {
                viewX
                
            } else if type == .Draw {
                viewDraw
            }
            
        } else {
            notFinished
        }
    }
        
        private var viewO: some View {
            
            Text("O")
                .font(.title3)
                .foregroundStyle(.blue)
                .bold()
            
            + Text(" ")
            
            + Text("wins!")
                .foregroundStyle(.white)
                .font(.title3)
        }
        
        private var viewX: some View {
            
            Text("X")
                .font(.title3)
                .foregroundStyle(.red)
                .bold()
            
            + Text(" ")
            
            + Text("wins!")
                .foregroundStyle(.white)
                .font(.title3)
        }
        
        private  var viewDraw: some View {
            
            Text("It's a draw!")
                .font(.title3)
                .foregroundStyle(.white)
        }
        
        private var notFinished: some View {
            
            Text("\(vm.currentPlayer.symbol)")
                .font(.title3)
                .foregroundStyle(vm.currentPlayer == .X ? .red : .blue)
            
            + Text("'s turn")
                .font(.title3)
                .foregroundStyle(.white)
            
        }
        
        
        
    }
    
    //#Preview {
    //    TextResult()
    //}
