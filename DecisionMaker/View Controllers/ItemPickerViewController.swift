//
//  ItemPickerViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/20/21.
//

import UIKit

class ItemPickerViewController: UIViewController {
    
    //=================
    // MARK: Properties
    //=================
    
    var addedItems = [String]()
    var backgroundIndex = 1
    
    // Outlets
    @IBOutlet weak var pickedItemLabel: UILabel!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clearButton: ButtonStyle!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Setup the buttons
        getButton.layer.cornerRadius = Constants.buttonCorners
        addButton.layer.cornerRadius = Constants.buttonCorners
        clearButton.layer.cornerRadius = Constants.buttonCorners
        
        // Setup the tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    //==============
    // MARK: Methods
    //==============
    
    // Dismiss the keyboard on touch
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        itemTextField.resignFirstResponder()
    }
    
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func AddTapped(_ sender: Any) {

        // Add if the textfield has text(check for spacing)
        if let text = itemTextField.text, !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty  {
            addedItems.append(itemTextField.text!)
        }
        
        
        
        // Clear the textfield
        itemTextField.text = ""
        
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
    
    
    @IBAction func getAnswerTapped(_ sender: Any) {
        
        if(addedItems.count > 0) {
            pickedItemLabel.text = addedItems[Int(arc4random_uniform(UInt32(addedItems.count)))]
            
            // Change the text of teh button
            getButton.setTitle("Again?", for: .normal)
        } else {
            let alertController = UIAlertController(title: "Alert", message: "You didn't add anything.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        // Dismiss the keyboard
        itemTextField.resignFirstResponder()
        
        
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        
        // Clear the array
        addedItems.removeAll()
        
        // Reset the get button
        getButton.setTitle("Get", for: .normal)
        
        // Reset the picked item label
        pickedItemLabel.text = "Winning Pick"
        
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: Constants.storyboard.menuVC) as! MenuViewController
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated:true, completion: nil)
        
    }
    
    
}
