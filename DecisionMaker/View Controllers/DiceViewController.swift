//
//  DiceViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/20/21.
//

import UIKit

class DiceViewController: UIViewController {
    
    //=================
    // MARK: Properties
    //=================
    let dice = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    
    // Outlets
    @IBOutlet weak var diceOne: UIImageView!
    @IBOutlet weak var diceTwo: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Allow for shake gesture
        self.becomeFirstResponder()
        
    }
    
    //==============
    // MARK: Methods
    //==============
    
    func rollDice() {
        
        // Get two random numbers
        let leftDie = Int(arc4random_uniform(6) + 1)
        let rightDie = Int(arc4random_uniform(6) + 1)
        
        // Set the images
        diceOne.image = UIImage(named: dice[leftDie - 1])
        diceTwo.image = UIImage(named: dice[rightDie - 1])
        
        // Set the total label
        totalLabel.text = "Total: \(leftDie + rightDie)"
        
        print(leftDie)
        print(rightDie)
        
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rollDice()
        }
    }
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func rollTapped(_ sender: Any) {
        rollDice()
    }
    
}
