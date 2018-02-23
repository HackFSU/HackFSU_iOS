//
//  tabBarVisualViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 2/15/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit

class tabBarVisualViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(red:1, green: 1, blue:1, alpha:1.0)
        self.tabBar.tintColor = UIColor(red:0, green:0, blue:0, alpha:1.0)
        self.tabBar.unselectedItemTintColor = UIColor(red:0, green:0, blue:0, alpha:0.5)

       
        
        
    }

  

   
}
