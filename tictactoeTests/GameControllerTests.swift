//
//  GameControllerTests.swift
//  tictactoeTests
//
//  Created by Cody Deckard on 6/26/19.
//  Copyright © 2019 Cody Deckard. All rights reserved.
//
import XCTest
@testable import tictactoe

class GameControllerTests: XCTestCase {

    var gameController: GameController?
    var testDouble: TestDouble?
    
    override func setUp() {
        //setUp code
        super.setUp()
        gameController = GameController()
        testDouble = TestDouble()
        
    }
    
    override func tearDown() {
        //tearDown code
        super.tearDown()
    }
    
    func testSetDelegate() {
        
        XCTAssertNil(gameController?.delegate)
        
        let delegate = TestDouble()
        
        gameController?.setDelegate(delegate)
        
        XCTAssertNotNil(gameController?.delegate)
        
    }
    
    func testSetStartPieceBlankThrows() {
        XCTAssertThrowsError(try gameController?.setStartPiece(as: .Blank))
    }
    
    func testSetStartPiece() {
        try? gameController?.setStartPiece(as: .O)
        XCTAssertEqual(gameController?.getCurrentTurn(), .O)
        try? gameController?.setStartPiece(as: .X)
        XCTAssertEqual(gameController?.getCurrentTurn(), .X)
    }
    
    func testPlayInvalidSpaceThrows() {
        XCTAssertThrowsError(try gameController?.playSpace(at: 0))
        
        XCTAssertThrowsError(try gameController?.playSpace(at: 10))
        
    }
    
    func testCannotPlaySameSpace() {
        _ = try? gameController?.playSpace(at: 1)
        
        XCTAssertThrowsError(try gameController?.playSpace(at: 1))
        
    }
    
    func testPlaySpaceUpdatesGameBoard() {
        gameController?.setDelegate(testDouble!)
        
        _ = try? gameController?.playSpace(at: 1)
        
        XCTAssertEqual(testDouble!.gameBoard.count,9)
        
        for (i,value) in testDouble!.gameBoard.enumerated() {
            if i != 0 {
               XCTAssertEqual(value, .Blank)
            }
            
        }
        
        
        XCTAssert(testDouble!.gameBoard[0] != .Blank)
        
        _ = try? gameController?.playSpace(at: 2)
        
        XCTAssert(testDouble!.gameBoard[1] != .Blank)
        XCTAssertNotEqual(testDouble!.gameBoard[1], testDouble?.gameBoard[0])
        
        
    }
    
}

class TestDouble : GameControllerDelegate {
    
    public var gameBoard: [spaceValue] = []
    
    func updateState(board: [spaceValue]) {
        self.gameBoard = board
    }
    
    func winner(who: spaceValue) {
        
    }
    
    func tie() {
        
    }
    
    
}
