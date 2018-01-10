//
//  InfoViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var mapScrollView: UIScrollView!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var mapView: UIView!
    
    var inMap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapScrollView.contentSize.height = 900
        self.navigationController?.navigationBar.isHidden = true
        
        if !inMap {
            mapView.layer.isHidden = true
            aboutButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            aboutButton.setTitleColor(UIColor(red:0.70, green:0.49, blue:0.98, alpha:1.0), for: UIControlState.normal)
            
        }else {
            mapView.layer.isHidden = false
        }
        mapButton.layer.borderWidth = 3
        mapButton.layer.cornerRadius = 15
        mapButton.layer.masksToBounds = true
        mapButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        aboutButton.layer.borderWidth = 3
        aboutButton.layer.cornerRadius = 15
        aboutButton.layer.masksToBounds = true
        aboutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    @IBAction func clickedMap(_ sender: Any) {
        if !inMap {
         mapView.layer.isHidden = false
         mapButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         aboutButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            
        //swapping text colors
         aboutButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: UIControlState.normal)
    
         mapButton.setTitleColor(UIColor(red:0.70, green:0.49, blue:0.98, alpha:1.0), for: UIControlState.normal)
    
         inMap = true
        }
        
    }
    @IBAction func clickAbout(_ sender: Any) {
        if inMap {
            mapView.layer.isHidden = true
            aboutButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            mapButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            
            //swapping text colors
            mapButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: UIControlState.normal)
            
            aboutButton.setTitleColor(UIColor(red:0.70, green:0.49, blue:0.98, alpha:1.0), for: UIControlState.normal)
        
            inMap = false
        }
    }
   
    
}


