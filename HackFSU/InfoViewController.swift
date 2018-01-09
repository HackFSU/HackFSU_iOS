//
//  InfoViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        notificationButton.layer.borderWidth = 3
        notificationButton.layer.cornerRadius = 15
        notificationButton.layer.masksToBounds = true
        notificationButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        aboutButton.layer.borderWidth = 3
        aboutButton.layer.cornerRadius = 15
        aboutButton.layer.masksToBounds = true
        aboutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


