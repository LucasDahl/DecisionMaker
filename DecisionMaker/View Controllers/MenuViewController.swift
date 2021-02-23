//
//  MenuViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/22/21.
//

import UIKit
import StoreKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //=================
    // MARK: Properties
    //=================
    
    
    let productID: NSString = "com.lucas.DecisionMaker"
    let defaults = UserDefaults.standard
    let sections = ["Buy", "Feedback", "share"]
    let titleOfCell = [["Purchase to remove adds","Restore purchases"], ["Feedback", "Write a review"], ["email", "message", "share"]]
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    //==============
    // MARK: Methods
    //==============
    
    // Actions ===============================
    
    func purchase() {
        IAPManager.shared.purchase(product: .adsRemoved)
    }
    
    func restorePurchase() {
        IAPManager.shared.purchase(product: .adsRemoved)
    }
    
    func feedback() {
        
    }
    
    func writeReview() {
        
    }
    
    func emailApp() {
        
    }
    
    func messageApp() {
        
    }
    
    func shareApp() {
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //========================================
    
    // TableView ===============================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleOfCell.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleOfCell[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        
        cell.textLabel?.text = titleOfCell[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the case
        let indexCell = titleOfCell[indexPath.section][indexPath.row]
        
        switch indexCell {
        case "Purchase to remove adds":
            purchase()
            break
        case "Restore purchases":
            restorePurchase()
            break
        case "Feedback":
            feedback()
            break
        case "Write a review":
            writeReview()
            break
        case "email":
            emailApp()
            break
        case "message":
            messageApp()
            break
        case "share":
            shareApp()
            break
        default:
            break
        }
        
        
    }
    
    //================
    // MARK: IBActions
    //================
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
