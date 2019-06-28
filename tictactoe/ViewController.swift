//
//  ViewController.swift
//  tictactoe
//
//  Created by Cody Deckard on 3/30/19.
//  Copyright © 2019 Cody Deckard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameController: GameControllerProtocol = GameController()
    @IBOutlet weak var PlayerIndicator: UIButton!
    
    @IBAction func setStartPlayer(_ sender: Any) {
        var currentPlayer = gameController.getCurrentTurn()
        
        currentPlayer = currentPlayer == .X ? .O : .X
        
        do {
            try gameController.setStartPiece(as: currentPlayer)
        } catch  {
            return
        }
        
        PlayerIndicator.setTitle("\(currentPlayer) Plays First", for: .normal)
        
        
    }
    @IBAction func resetBoard(_ sender: Any) {
        gameController.resetBoard()
        PlayerIndicator.isEnabled = true
        let firstPlayer = gameController.getCurrentTurn()
        
        PlayerIndicator.setTitle("\(firstPlayer) Plays First", for: .normal)
        
        for i in 1...9 {
            let tempButton = self.view.viewWithTag(i) as? UIButton
            
            tempButton?.setImage(nil, for: .normal)
        }
        
    }
    
    @IBAction func selectSpace(sender: AnyObject?) {
        
        guard let button = sender as? UIButton else {
            return
        }
        
        if PlayerIndicator.isEnabled {
            PlayerIndicator.isEnabled = false
        }
        
       // let currentPlayer = gameController.getCurrentTurn()
        //var success = false
        
        do {
            _ = try gameController.playSpace(at: button.tag)
        }  catch playError.SpaceNotBlank {
            print("Cannot Play there, it has already been played")
            return
        } catch playError.OffBoard {
            print("invalid play")
            return
        } catch {
            return
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let firstPlayer = gameController.getCurrentTurn()
        
        PlayerIndicator.setTitle("\(firstPlayer) Plays First", for: .normal)
        
        gameController.setDelegate(self)
        
    }


}

// MARK - GameControllerDelegate
extension ViewController: GameControllerDelegate {
    func updateState(board: [spaceValue]) {
        
        for (i, value) in board.enumerated() {
            guard value != .Blank else {
                continue
            }
            
            guard let button = self.view.viewWithTag(i+1) as? UIButton else {
                return
            }
            
            if button.image(for: .normal) == nil {
                
                let image = value == .X ? "cross" : "nought"
                button.setImage(UIImage(named: image), for: .normal)
            }
        }
    }
    
    func winner(who: spaceValue) {
        
        let alert = UIAlertController(title: "\(who) has won!", message: "\(who) Won !!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func tie() {
        let tie = UIAlertController(title: "Cats game!", message: "Cats Game ! - Tie", preferredStyle: .alert)
        tie.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(tie, animated: true)
    }
}
