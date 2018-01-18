//
//  NotificationAfterLoginViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 1/10/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit
import Foundation

class NotificationAfterLoginViewController: UIViewController {

    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var backGroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noButton.layer.cornerRadius = 20.0
        noButton.layer.masksToBounds = true
        noButton.layer.borderWidth = 1
        noButton.layer.borderColor = #colorLiteral(red:1.00, green:0.38, blue:0.82, alpha:1.0)
        //How to set borderColor
        //#colorLiteral(red:1.00, green:0.38, blue:0.82, alpha:1.0)
        
        yesButton.layer.cornerRadius = 20.0
        yesButton.layer.masksToBounds = true
        yesButton.layer.borderWidth = 1
        yesButton.layer.borderColor = #colorLiteral(red:1.00, green:0.38, blue:0.82, alpha:1.0)
        
      
        backGroundView.layer.cornerRadius = 30.0
        backGroundView.layer.masksToBounds = true
        
    }

    @IBAction func clickedYes(_ sender: Any) {
        
        //handle all notification things
        
    }
    
    @IBAction func clickedNo(_ sender: Any) {
        //don't do 2
        
    }
    
    
    
}




