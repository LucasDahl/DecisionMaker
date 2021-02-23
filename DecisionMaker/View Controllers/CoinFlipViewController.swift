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
    var backgroundIndex = 1
    
    // Outlets
    @IBOutlet weak var coin: UIImageView!
    @IBOutlet weak var headsOrTailsLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Allow for shake gesture
        self.becomeFirstResponder()
        
        // Setup the buttons
        flipButton.layer.cornerRadius = Constants.buttonCorners
        
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
        
        // Set the background image
        backgroundImage.image = UIImage(named: "background\(backgroundIndex)")
        
        // Increase the index, but check that its not more
        // than 4
        if(backgroundIndex < 4) {
            backgroundIndex += 1
        } else if (backgroundIndex == 4) {
            backgroundIndex = 1
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
    
    
    @IBAction func menuTapped(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: Constants.storyboard.menuVC) as! MenuViewController
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated:true, completion: nil)
        
    }
    
}
