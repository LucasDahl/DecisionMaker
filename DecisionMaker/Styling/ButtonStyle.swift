//
//  ButtonStyle.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/22/21.
//

import UIKit

class ButtonStyle: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        // Setup
        self.backgroundColor = .clear
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor(white: 1.0, alpha: 0.25).cgColor
        self.alpha = 0.75
    }
    
}
