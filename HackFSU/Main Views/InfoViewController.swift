//
//  InfoViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var firstFloorButton: UIButton!
    @IBOutlet var secondFloorButton: UIButton!
    @IBOutlet var thirdFloorButton: UIButton!
    @IBOutlet var fourthFloorButton: UIButton!
    
    @IBOutlet var mapDisplayImage: UIImageView!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var mapView: UIView!
    
    var inMap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        
        //MAP FLOOR BUTTON SETUP
        //How to set purple borderColor
        //#colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        firstFloorButton.layer.cornerRadius = 11.0
        firstFloorButton.layer.masksToBounds = true
        firstFloorButton.layer.borderWidth = 0
        firstFloorButton.layer.borderColor = #colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        
        secondFloorButton.layer.cornerRadius = 11.0
        secondFloorButton.layer.masksToBounds = true
        secondFloorButton.layer.borderWidth = 2
        secondFloorButton.layer.borderColor = #colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        
        thirdFloorButton.layer.cornerRadius = 11.0
        thirdFloorButton.layer.masksToBounds = true
        thirdFloorButton.layer.borderWidth = 0
        thirdFloorButton.layer.borderColor = #colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        
        fourthFloorButton.layer.cornerRadius = 11.0
        fourthFloorButton.layer.masksToBounds = true
        fourthFloorButton.layer.borderWidth = 0
        fourthFloorButton.layer.borderColor = #colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        
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
   
    @IBAction func clickedNewLevel(_ sender: UIButton) {
        if sender.titleLabel?.text! == "ONE"{
            mapDisplayImage.image = #imageLiteral(resourceName: "diracFloor1")
            firstFloorButton.layer.borderWidth = 2
            secondFloorButton.layer.borderWidth = 0
            thirdFloorButton.layer.borderWidth = 0
            fourthFloorButton.layer.borderWidth = 0
            
        }else if sender.titleLabel?.text! == "TWO"{
            mapDisplayImage.image = #imageLiteral(resourceName: "diracFloor2")
            firstFloorButton.layer.borderWidth = 0
            secondFloorButton.layer.borderWidth = 2
            thirdFloorButton.layer.borderWidth = 0
            fourthFloorButton.layer.borderWidth = 0
            
        }else if sender.titleLabel?.text! == "THREE"{
            mapDisplayImage.image = #imageLiteral(resourceName: "diracFloor3")
            firstFloorButton.layer.borderWidth = 0
            secondFloorButton.layer.borderWidth = 0
            thirdFloorButton.layer.borderWidth = 3
            fourthFloorButton.layer.borderWidth = 0
            
        }else if sender.titleLabel?.text! == "FOUR"{
             mapDisplayImage.image = #imageLiteral(resourceName: "diracFloor3")
            firstFloorButton.layer.borderWidth = 0
            secondFloorButton.layer.borderWidth = 0
            thirdFloorButton.layer.borderWidth = 0
            fourthFloorButton.layer.borderWidth = 2
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}


