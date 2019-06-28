//
//  GameController.swift
//  tictactoe
//
//  Created by Cody Deckard on 6/22/19.
//  Copyright © 2019 Cody Deckard. All rights reserved.
//

class GameController : GameControllerProtocol {
    
    private var gameBoard: [spaceValue] = []
    weak var delegate: GameControllerDelegate?
    private var currentTurn: spaceValue = .X
    private var winner: Bool = false
    private var numMoves = 0
    private let winningMoves: [[[Int]]] = [
    [[1,1,1], [0,0,0], [0,0,0]],
    [[0,0,0], [1,1,1], [0,0,0]],
    [[0,0,0], [0,0,0], [1,1,1]],
    [[1,0,0], [1,0,0], [1,0,0]],
    [[0,1,0], [0,1,0], [0,1,0]],
    [[0,0,1], [0,0,1], [0,0,1]],
    [[1,0,0], [0,1,0], [0,0,1]],
    [[0,0,1], [0,1,0], [1,0,0]]
    ]
    
    init() {
        resetBoard()
    }
    
    func getWinner() -> Bool {
        return winner
    }
    
    func evalBoard() {
        guard numMoves >= 5 else {
            return
        }
        var winningBoard = true
        for i in 0..<winningMoves.count {
            for j in 0..<3 {
                
                if !winningBoard {
                    break
                }
                
                for k in 0..<3 {
                    if winningMoves[i][j][k] == 1 && gameBoard[(3 * j)+k] == currentTurn {
                        continue
                    } else if winningMoves[i][j][k] == 1 {
                        winningBoard = false
                        break
                    }
                }
            }
            
            // This is a winning board
            if winningBoard {
                winner = true
                delegate?.winner(who: currentTurn)
        
            } else {
            // This is not a winning board, check the next board and set it to true
                winningBoard = true
            }
            
        }
        winner = false
        
        if numMoves == 9 {
            delegate?.tie()
        }
        
    }
    
    func resetBoard() {
        gameBoard = []
        numMoves = 0
        winner = false
        for _ in 1...9 {
            gameBoard.append(.Blank)
        }
        
        currentTurn = .X
        
    }
    
    func setStartPiece(as piece: spaceValue) throws {
        
        guard piece != .Blank else {
            throw playError.InvalidInitialTurn
        }
        
        self.currentTurn = piece
    }
    
    func getCurrentTurn() -> spaceValue {
        return currentTurn
    }
    
    func playSpace(at location: Int) throws -> Bool {
        
        guard location >= 1 && location <= 9 else {
            throw playError.OffBoard
        }
        
        guard gameBoard[location - 1] == .Blank else {
            throw playError.SpaceNotBlank
        }
        
        guard winner == false else {
            return false
        }
        
        gameBoard[location - 1] = currentTurn
        
        numMoves += 1
        delegate?.updateState(board: gameBoard)
        print(gameBoard)
        
        evalBoard()
        
        currentTurn = currentTurn == .X ? .O : .X
   
        return true
    }
    
    func setDelegate(_ delegate: GameControllerDelegate) {
        self.delegate = delegate
    }
    
}

enum spaceValue {
    case Blank
    case X
    case O
}

enum gameState {
    case Winner
    case NoWinner
    case CatsGame
}

enum playError: Error {
    case OffBoard
    case SpaceNotBlank
    case InvalidInitialTurn
}

protocol GameControllerProtocol {
    func setStartPiece(as piece: spaceValue) throws
    func playSpace(at location: Int) throws -> Bool
    func getCurrentTurn() -> spaceValue
    func resetBoard()
    func getWinner() -> Bool
    func setDelegate(_ delegate: GameControllerDelegate)
}

protocol GameControllerDelegate: AnyObject {
    func updateState(board: [spaceValue])
    func winner(who: spaceValue)
    func tie()
}
