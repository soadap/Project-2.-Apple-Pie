//
//  PlayerController.swift
//  Apple Pie
//
//  Created by soadap on 1/17/19.
//  Copyright © 2019 soadap. All rights reserved.
//

import UIKit

class PlayerController: UIViewController {

    var players = 1
    let game = Game.sharedInstance
    @IBOutlet weak var numberOfPlayers: UITextField!
    @IBOutlet var playerButton : [UIButton]!
    @IBAction func playerButtonPressed(_ sender: UIButton) {
        for btn in playerButton {
            if btn != sender {btn.setTitleColor(UIColor.gray, for: .normal)}
        }
        sender.setTitleColor(UIColor.blue, for: .normal)
        players = sender.tag
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        game.numberOfPlayers = players
        performSegue(withIdentifier: "openGame", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerButtonPressed(playerButton[0])
    }
    
}
