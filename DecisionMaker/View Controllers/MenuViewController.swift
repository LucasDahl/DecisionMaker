//
//  MenuViewController.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/22/21.
//

import UIKit
import StoreKit
import MessageUI

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    //=================
    // MARK: Properties
    //=================
    
    
    let productID: NSString = "com.lucas.DecisionMaker"
    let defaults = UserDefaults.standard
    let sections = ["Buy", "Feedback"]
    let titleOfCell = [["Purchase to remove ads","Restore purchases"], ["Feedback"]]
    
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
        IAPManager.shared.restorePurchase()
    }
    
    func feedback() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["LucasDahlApp@gmail.com"])
            mail.setSubject("Feed back on App")
            
            present(mail, animated: true)
        } else {
            let alertController = UIAlertController(title: "Alert", message: "Could not generate email.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
        case "Purchase to remove ads":
            purchase()
            break
        case "Restore purchases":
            restorePurchase()
            break
        case "Feedback":
            feedback()
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
