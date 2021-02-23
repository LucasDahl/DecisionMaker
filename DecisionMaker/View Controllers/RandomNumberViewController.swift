//
//  RandomNumberViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/21/21.
//

import UIKit

class RandomNumberViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //=================
    // MARK: Properties
    //=================
    
    var backgroundIndex = 1
    var numbers = [Int]()
    
    @IBOutlet weak var randomNumLabel: UILabel!
    @IBOutlet weak var maxNumField: UITextField!
    @IBOutlet weak var minNumField: UITextField!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clearButton: ButtonStyle!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Allow for shake gesture
        self.becomeFirstResponder()
        
        // Setup the button
        randomizeButton.layer.cornerRadius = Constants.buttonCorners
        clearButton.layer.cornerRadius = Constants.buttonCorners
        
        // Setup the pickerView
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    //==============
    // MARK: Methods
    //==============
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])"
    }
    
    func generateNumber() {
        
        let min = Int(minNumField.text!)
        let max = Int(maxNumField.text!)
        let num = Int.random(in: min!..<max! + 1)
        
        // Add to the array
        numbers.append(num)
        
        // Set the label
        randomNumLabel.text = "\(num)"
        
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
            generateNumber()
        }
    }
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func getRandomNum(_ sender: Any) {
        
        generateNumber()
        
        // Reload the picker view
        picker.reloadAllComponents()
        
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        
        // Clear the array
        numbers.removeAll()
        
        // Reload the pickerview
        picker.reloadAllComponents()
        
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: Constants.storyboard.menuVC) as! MenuViewController
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated:true, completion: nil)
        
    }
    
}
