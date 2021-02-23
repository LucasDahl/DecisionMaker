//
//  Constants.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/22/21.
//

import UIKit

struct Constants {
    
    // Button styling
    static let buttonCorners: CGFloat = 25
    
    struct storyboard {
        
        static let menuVC = "MenuViewController"
        
    }
    
    static func removeAllAdds() {
        
        if !UserDefaults.standard.bool(forKey: "adsRemoved") {
            // Show adds
        } else {
            // remove adds
        }
        
    }
    
}
