//
//  CoinFlipViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/20/21.
//

import UIKit

class CoinFlipViewController: UIViewController {
    
    //=================
    // MARK: Properties
    //=================
    
    let coins = ["coin1", "coin2"]
    
    // Outlets
    @IBOutlet weak var coin: UIImageView!
    @IBOutlet weak var headsOrTailsLabel: UILabel!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Allow for shake gesture
        self.becomeFirstResponder()
        
    }
    
    //==============
    // MARK: Methods
    //==============
    
    func flipCoin() {
        
        // Get a random number
        let headsTails = Int(arc4random_uniform(2))
        
        // Set the coing image
        coin.image = UIImage(named: coins[headsTails])
        
        // Set the label
        if(headsTails == 0) {
            headsOrTailsLabel.text = "Heads!"
        } else {
            headsOrTailsLabel.text = "Tails!"
        }
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
            flipCoin()
        }
        
    }
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func flipTapped(_ sender: Any) {
        flipCoin()
    }
    
}
