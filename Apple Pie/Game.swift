//
//  Game.swift
//  Apple Pie
//
//  Created by soadap on 1/15/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import Foundation
import UIKit

class Game {
    
    let numberOfAttempts = 7
    var isFirst = true
    
    static let sharedInstance = Game()
    private init() {}
    var scoreArray = [Player]()
    
    var currentPlayer: Int {
        if isFirst {return 0} else {return 1}
    }
    
    var otherPlayer: Int {
        if !isFirst {return 0} else {return 1}
    }

    var numberOfPlayers = 1 {
        didSet {
            scoreArray.append(Player(score:0,attempts:numberOfAttempts,wins:0,loses:0,color:UIColor.blue))
            scoreArray.append(Player(score:0,attempts:numberOfAttempts,wins:0,loses:0,color:UIColor.yellow))
        }
    }
    
    var word = ""
    var guessedLetters = [Character]()
    
    func newWord(_ word: String) {
        self.word = word
        scoreArray[0].attempts = numberOfAttempts
        scoreArray[1].attempts = numberOfAttempts
        guessedLetters.removeAll()
    }
    
    func nextPlayer() {
        if numberOfPlayers == 2 {
            isFirst = !isFirst
        }
    }
    
    func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        print(letter)
        if !word.contains(letter) {
            scoreArray[currentPlayer].attempts -= 1
            nextPlayer()
        } else {
            scoreArray[currentPlayer].score += 1
        }
    }
    
    var fomattedWord: String {
        var guessedWord = ""
        for letters in word {
            if guessedLetters.contains(letters) {
                guessedWord += "\(letters)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    func playerWins(_ pl: Int, _ score: Int) {
        if pl == currentPlayer {
            scoreArray[currentPlayer].wins += 1
            scoreArray[currentPlayer].score += score
            scoreArray[otherPlayer].loses += 1
        } else {
            scoreArray[currentPlayer].loses += 1
            scoreArray[otherPlayer].wins += 1
        }
    }
}
