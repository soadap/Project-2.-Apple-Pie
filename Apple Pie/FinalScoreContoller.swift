//
//  FinalScoreContoller.swift
//  Apple Pie
//
//  Created by soadap on 1/20/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import UIKit

class FinalScoreContoller: UIViewController {

    let game = Game.sharedInstance
    
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerOneWinsLoses: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var playerTwoWinsLoses: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if game.numberOfPlayers == 1 {
            playerTwoScore.isHidden = true
            playerTwoWinsLoses.isHidden = true
        }
        playerOneScore.text = "Player One Score: \(game.scoreArray[0].score)"
        playerOneWinsLoses.text = "Wins: \(game.scoreArray[0].wins), Loses: \(game.scoreArray[0].loses)"
        playerTwoScore.text = "Player Two Score: \(game.scoreArray[1].score)"
        playerTwoWinsLoses.text = "Wins: \(game.scoreArray[1].wins), Loses: \(game.scoreArray[1].loses)"
    }

}
