//
//  ViewController.swift
//  judgeViewTesting
//
//  Created by Andres Ibarra on 1/12/18.
//  Copyright © 2018 Andres Ibarra. All rights reserved.
//

import UIKit

//key is hack #, value is hack table
var givenHacks = ["1":"20", "2":"25", "3":"10"]


class InitialHackViewController: UIViewController {

    @IBOutlet var firstHackView: UIView!
    @IBOutlet var firstHackLabel: UILabel!
    
    @IBOutlet var secondHackView: UIView!
    @IBOutlet var secondHackLabel: UILabel!
    
    @IBOutlet var thirdHackView: UIView!
    @IBOutlet var thirdHackLabel: UILabel!
    
    @IBOutlet var startJudginButton: UIButton!
    @IBOutlet var leaveJudging: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        givenHacks["1"] = String(arc4random_uniform(50)+1)
        givenHacks["2"] = String(arc4random_uniform(50)+1)
        givenHacks["3"] = String(arc4random_uniform(50)+1)
        
        
        
        //visual Formatting
        startJudginButton.layer.cornerRadius = 30.0
        startJudginButton.layer.masksToBounds = true
        leaveJudging.layer.cornerRadius = 30.0
        leaveJudging.layer.masksToBounds = true
        
        firstHackView.layer.cornerRadius = 30.0
        firstHackView.layer.masksToBounds = true
        firstHackView.isHidden = true
        secondHackView.layer.cornerRadius = 30.0
        secondHackView.layer.masksToBounds = true
        secondHackView.isHidden = true
        
        thirdHackView.layer.cornerRadius = 30.0
        thirdHackView.layer.masksToBounds = true
        thirdHackView.isHidden = true
        
        //positional Formatting
        firstHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -80)
        secondHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -80)
        thirdHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -80)
        
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/8.5)
        leaveJudging.layer.position = CGPoint(x: (self.view.bounds.width)/4, y: (6*self.view.bounds.height)/7)
        startJudginButton.layer.position = CGPoint(x: (3*self.view.bounds.width)/4, y: (6*self.view.bounds.height)/7)

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        firstHackView.isHidden = false
        secondHackView.isHidden = false
        thirdHackView.isHidden = false
        
        firstHackLabel.text = "TABLE #\(String(describing: givenHacks["1"]!))"
        secondHackLabel.text = "TABLE #\(String(describing: givenHacks["2"]!))"
        thirdHackLabel.text = "TABLE #\(String(describing: givenHacks["3"]!))"
    }
    
    override func viewDidAppear(_ animated: Bool){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.firstHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -50)
            self.firstHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/4)
            self.firstHackLabel.layer.position = CGPoint(x: self.firstHackView.bounds.width/2, y: self.firstHackView.bounds.height/2)
            
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.secondHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -50)
            self.secondHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: (1.8*self.view.bounds.height)/4)
            self.secondHackLabel.layer.position = CGPoint(x: self.secondHackView.bounds.width/2, y: self.secondHackView.bounds.height/2)
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.thirdHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: -50)
            self.thirdHackView.layer.position = CGPoint(x: self.view.bounds.width/2, y: (2.6*self.view.bounds.height)/4)
            self.thirdHackLabel.layer.position = CGPoint(x: self.thirdHackView.bounds.width/2, y: self.thirdHackView.bounds.height/2)
        }, completion: nil)
        
    }

   
    //only needed to properly return from login
    @IBAction func restartHacks(unwindSegue: UIStoryboardSegue) {
        
    }


}

