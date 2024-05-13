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
            
            if type == .O || type == .OwithOpacity {
                
                viewO
                
            } else if type == .X || type == .XwithOpacity {
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
                .font(.system(size: 20))
                .foregroundStyle(.blue)
                .bold()
            
            + Text(" ")
            
            + Text("wins!")
                .foregroundStyle(.white)
                .font(.system(size: 20))
        }
        
        private var viewX: some View {
            
            Text("X")
                .font(.system(size: 20))
                .foregroundStyle(.red)
                .bold()
            
            + Text(" ")
            
            + Text("wins!")
                .foregroundStyle(.white)
                .font(.system(size: 20))
        }
        
        private  var viewDraw: some View {
            
            Text("It's a draw!")
                .font(.system(size: 20))
                .foregroundStyle(.white)
        }
        
        private var notFinished: some View {
            
            Text("\(vm.currentPlayer.symbol)")
                .font(.system(size: 20))
                .foregroundStyle(vm.currentPlayer == .X ? .red : .blue)
            
            + Text("'s turn")
                .font(.system(size: 20))
                .foregroundStyle(.white)
            
        }
        
        
        
    }
    
    //#Preview {
    //    TextResult()
    //}
