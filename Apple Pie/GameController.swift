//
//  ViewController.swift
//  Apple Pie
//
//  Created by soadap on 1/15/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    let game = Game.sharedInstance
    
    var listOfWords = ["apple","banana","orange","watermelon","peach"]
    
    @IBOutlet weak var treeImage : UIImageView!
    @IBOutlet weak var wordLabel : UILabel!
    @IBOutlet weak var winLoseLabel : UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var guessTheWordButton: UIButton!
    
    
    @IBOutlet var letterButton : [UIButton]!
    
    @IBAction func guessButton(_ sender: Any) {
        let alert = UIAlertController(title: "Guess The Word", message: "Enter the word:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default
            , handler: { (_) in
                let guessText = alert.textFields![0].text?.lowercased()
                if guessText != nil {
                    self.wordGuess(guessText!)
                }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = Character(sender.title(for: .normal)!.lowercased())
        game.playerGuessed(letter: letterString)
        updateGameState()
    }

    func wordGuess(_ wordTryGuess: String) {
        if wordTryGuess.folding(options: .diacriticInsensitive, locale: .current) == game.word.lowercased() {
            game.playerWins(game.currentPlayer, 50)
            newRound()
        } else {
            game.playerGuessed(letter: " ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            game.newWord(newWord)
            setLetterButtons(true)
        } else {
            setLetterButtons(false)
            performSegue(withIdentifier: "finalScore", sender: nil)
        }
        updateUI()
    }

    func updateUI() {
        winLoseLabel.text = "Wins: \(game.scoreArray[game.currentPlayer].wins) / Loses: \(game.scoreArray[game.currentPlayer].loses)"
        scoreLabel.text = "Player \(game.currentPlayer+1) score: \(game.scoreArray[game.currentPlayer].score)"
        treeImage.backgroundColor = game.scoreArray[game.currentPlayer].color
        treeImage.image = UIImage(named: "Tree \(game.scoreArray[game.currentPlayer].attempts)")

        var wordLetterArray = [String]()
        wordLetterArray = game.fomattedWord.map {"\($0)"}
        let wordWithSpace = wordLetterArray.joined(separator: " ")
        wordLabel.text = wordWithSpace

    }
    
    func updateGameState() {
        if game.scoreArray[game.currentPlayer].attempts == 0 {
            game.playerWins(game.otherPlayer, 0)
            newRound()
        } else if game.word == game.fomattedWord {
            game.playerWins(game.currentPlayer, 10)
            newRound()
        }
        updateUI()
    }
    
    func setLetterButtons(_ enable: Bool) {
        for button in letterButton {
            button.isEnabled = enable
        }
        guessTheWordButton.isEnabled = enable
    }
}

