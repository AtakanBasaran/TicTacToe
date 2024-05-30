//
//  ViewModelTests.swift
//  TicTacToeNewTests
//
//  Created by Atakan Başaran on 30.05.2024.
//

import XCTest
@testable import TicTacToeNew

final class ViewModelTests: XCTestCase {
    
    var vm: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vm = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        
        XCTAssertEqual(vm.currentPlayer, .X)
        XCTAssertNil(vm.winner)
    }
    
    
    func testMakeMove() {
        vm.makeMove(row: 0, col: 0)
        XCTAssertEqual(vm.board[0][0], .X)
        XCTAssertEqual(vm.currentPlayer, .O)
        XCTAssertEqual(vm.playerMoves[.X]?.count, 1)
    }
    
    
    func testWinner() {
        
        vm.board = [
            [.O, .X, .X],
            [nil, nil, nil],
            [nil, .X, .O]
        ]
        
        vm.currentPlayer = .O
        vm.makeMove(row: 1, col: 1)
        XCTAssertEqual(vm.winner, .O)
    }
    
    func testDraw() {
        
        vm.board = [
            [.O, .X, .O],
            [.O, .X, nil],
            [.X, .O, .X]
        ]
        
        vm.currentPlayer = .X
        vm.makeMove(row: 1, col: 2)
        XCTAssertEqual(vm.winner, .Draw)
    }
    
    
    func testResetGame() {
        vm.board = [
            [.O, .X, .O],
            [.O, .X, .X],
            [.X, .O, .X]
        ]
        
        vm.winner = .Draw
        vm.resetGame()
        
        XCTAssertNil(vm.winner)
        XCTAssertEqual(vm.board.count, 3)
        XCTAssertEqual(vm.currentPlayer, .X)
    }
    

}
