//
//  EightBallViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/21/21.
//

import UIKit

class EightBallViewController: UIViewController {
    
    //=================
    // MARK: Properties
    //=================
    
    @IBOutlet weak var eightBallImageView: UIImageView!
    @IBOutlet weak var askButton: UIButton!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Allow for shake gesture
        self.becomeFirstResponder()
        
        // Setup the button
        askButton.layer.cornerRadius = Constants.buttonCorners
        
    }
    
    //==============
    // MARK: Methods
    //==============
    
    func getBallImage() {
        eightBallImageView.image = UIImage(named: "ball\(Int(arc4random_uniform(5) + 1))")
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
            getBallImage()
        }
    }
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func askEightBallTapped(_ sender: Any) {
        getBallImage()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: Constants.storyboard.menuVC) as! MenuViewController
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated:true, completion: nil)
        
    }
    
}
