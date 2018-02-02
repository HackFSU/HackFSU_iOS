//
//  FinalRankingViewController.swift
//  judgeViewTesting
//
//  Created by Andres Ibarra on 1/12/18.
//  Copyright © 2018 Andres Ibarra. All rights reserved.
//

import UIKit
import Alamofire

var rankedHacks = ["1":"", "2":"", "3":""]

class FinalRankingViewController: UIViewController {
    
    var firstSelected = false
    var secondSelected = false
    var thirdSelected = false
    
    @IBOutlet var rankyourHacks: UILabel!
    @IBOutlet var simplyDragLabel: UILabel!
    
    @IBOutlet var firstplaceLabel: UILabel!
    @IBOutlet var firstPlaceholder: UILabel!
    
    @IBOutlet var secondplaceLabel: UILabel!
    @IBOutlet var secondPlaceholder: UILabel!
    
    @IBOutlet var thirdplaceLabel: UILabel!
    @IBOutlet var thirdPlaceholder: UILabel!
    
    @IBOutlet var firstHack: UIView!
    @IBOutlet var secondHack: UIView!
    @IBOutlet var thirdHack: UIView!
    
    var panGesture1 = UIPanGestureRecognizer()
    var panGesture2 = UIPanGestureRecognizer()
    var panGesture3 = UIPanGestureRecognizer()
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstSelected = false
        secondSelected = false
        thirdSelected = false

        
        panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(FinalRankingViewController.draggedView1(_:)))
        firstHack.isUserInteractionEnabled = true
        firstHack.addGestureRecognizer(panGesture1)
        firstHack.layer.cornerRadius = 20.0;
        firstHack.layer.masksToBounds = true
        firstHack.layer.position = CGPoint(x: 0.75*self.view.bounds.width/3, y: (6.5*self.view.bounds.height/7))
        
        
        
        panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(FinalRankingViewController.draggedView2(_:)))
        secondHack.isUserInteractionEnabled = true
        secondHack.addGestureRecognizer(panGesture2)
        secondHack.layer.cornerRadius = 20.0;
        secondHack.layer.masksToBounds = true
        secondHack.layer.position = CGPoint(x: (1.50*self.view.bounds.width)/3, y: (5.5*self.view.bounds.height/7))
        
        panGesture3 = UIPanGestureRecognizer(target: self, action: #selector(FinalRankingViewController.draggedView3(_:)))
        thirdHack.isUserInteractionEnabled = true
        thirdHack.addGestureRecognizer(panGesture3)
        thirdHack.layer.cornerRadius = 20.0;
        thirdHack.layer.masksToBounds = true
        thirdHack.layer.position = CGPoint(x: (2.25*self.view.bounds.width)/3, y: (6.5*self.view.bounds.height/7))
        
        firstplaceLabel.layer.position = CGPoint(x: self.view.bounds.width/6, y: (1.5*self.view.bounds.height/6))
        secondplaceLabel.layer.position = CGPoint(x: self.view.bounds.width/6, y: (2.6*self.view.bounds.height/6))
        thirdplaceLabel.layer.position = CGPoint(x: self.view.bounds.width/6, y: (3.7*self.view.bounds.height/6))
        
        firstPlaceholder.layer.position = CGPoint(x: (1.2*self.view.bounds.width)/3, y: (1.5*self.view.bounds.height/6))
        secondPlaceholder.layer.position = CGPoint(x: (1.2*self.view.bounds.width)/3, y: (2.6*self.view.bounds.height/6))
        thirdPlaceholder.layer.position = CGPoint(x: (1.2*self.view.bounds.width)/3, y: (3.7*self.view.bounds.height/6))
        
   
        doneButton.layer.cornerRadius = 30.0
        doneButton.layer.masksToBounds = true
        
        firstPlaceholder.layer.cornerRadius = 10.0
        firstPlaceholder.layer.borderWidth = 2.0
        firstPlaceholder.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        secondPlaceholder.layer.cornerRadius = 10.0
        secondPlaceholder.layer.borderWidth = 2.0
        secondPlaceholder.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        thirdPlaceholder.layer.cornerRadius = 10.0
        thirdPlaceholder.layer.borderWidth = 2.0
        thirdPlaceholder.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        rankyourHacks.layer.position = CGPoint(x: self.view.bounds.width/2, y: (self.view.bounds.height/10))
        simplyDragLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: (self.view.bounds.height/10)+20)
        
        doneButton.isHidden = true
        doneButton.layer.position = CGPoint(x: self.view.bounds.width/2, y: (9*self.view.bounds.height/10))
        
        if nosecond{
            
            secondPlaceholder.layer.isHidden = true
            secondplaceLabel.layer.isHidden = true
            secondHack.layer.isHidden = true
            secondSelected = true
        }
        
        
        if nothird{
            
            thirdPlaceholder.layer.isHidden = true
            thirdplaceLabel.layer.isHidden = true
            thirdHack.layer.isHidden = true
            thirdSelected = true
        }
        
        
        
        
        
    }

    @objc func draggedView1(_ sender:UIPanGestureRecognizer){
        self.view.bringSubview(toFront: firstHack)
        let translation = sender.translation(in: self.view)
        firstHack.center = CGPoint(x: firstHack.center.x + translation.x, y: firstHack.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        handlePan1(sender)
    }
    
    @objc func draggedView2(_ sender:UIPanGestureRecognizer){
        
        self.view.bringSubview(toFront: secondHack)
        let translation = sender.translation(in: self.view)
        secondHack.center = CGPoint(x: secondHack.center.x + translation.x, y: secondHack.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        handlePan2(sender)
    }
    @objc func draggedView3(_ sender:UIPanGestureRecognizer){
       
        self.view.bringSubview(toFront: thirdHack)
        let translation = sender.translation(in: self.view)
        thirdHack.center = CGPoint(x: thirdHack.center.x + translation.x, y: thirdHack.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        handlePan3(sender)
    }
    
    func handlePan1(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended{
            checkWhatPlace(givenView: "1")
        }
        
    }
    
    func handlePan2(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended{
            checkWhatPlace(givenView: "2")
        }
        
    }
    
    func handlePan3(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended{
            checkWhatPlace(givenView: "3")
            
        }
        
    }
    
    func checkWhatPlace(givenView: String){
        let firstplaceLocationPoint = firstPlaceholder.layer.frame
        let secondplaceLocationPoint = secondPlaceholder.layer.frame
        let thirdplaceLocationPoint = thirdPlaceholder.layer.frame
        
        
        
        
        if givenView == "1"{
            //check first hack's location
            if firstHack.frame.contains(firstplaceLocationPoint){
                firstHack.layer.position = firstPlaceholder.layer.position
                firstSelected = true
                rankedHacks["1"] = givenHacks["1"]
               
                
            }else if firstHack.frame.contains(secondplaceLocationPoint){
                firstHack.layer.position = secondPlaceholder.layer.position
                secondSelected = true
                rankedHacks["2"] = givenHacks["1"]
              
                
            }else if firstHack.frame.contains(thirdplaceLocationPoint){
                firstHack.layer.position = thirdPlaceholder.layer.position
                thirdSelected = true
                rankedHacks["3"] = givenHacks["1"]
                
                
            }else{
                if rankedHacks["1"] == "1"{
                    //deselect 1
                    rankedHacks["1"] = nil
                    firstSelected = false
                }else if rankedHacks["2"] == "1"{
                    //deselect 1
                    rankedHacks["2"] = nil
                    secondSelected = false
                }else if rankedHacks["3"] == "1"{
                    //deselect 1
                    rankedHacks["3"] = nil
                    thirdSelected = false
                }
                
                
            }
           
            
        
        }else if givenView == "2"{
            //check second hack's location
            if secondHack.frame.contains(firstplaceLocationPoint){
                secondHack.layer.position = firstPlaceholder.layer.position
                firstSelected = true
                rankedHacks["1"] = givenHacks["2"]
                
                
            }else if secondHack.frame.contains(secondplaceLocationPoint){
                secondHack.layer.position = secondPlaceholder.layer.position
                secondSelected = true
                rankedHacks["2"] = givenHacks["2"]
                
                
            }else if secondHack.frame.contains(thirdplaceLocationPoint){
                secondHack.layer.position = thirdPlaceholder.layer.position
                thirdSelected = true
                rankedHacks["3"] = givenHacks["2"]
                
                
            }else{
                if rankedHacks["1"] == "2"{
                    //deselect 1
                    rankedHacks["1"] = nil
                    firstSelected = false
                }else if rankedHacks["2"] == "2"{
                    //deselect 1
                    rankedHacks["2"] = nil
                    secondSelected = false
                }else if rankedHacks["3"] == "2"{
                    //deselect 1
                    rankedHacks["3"] = nil
                    thirdSelected = false
                }
                
                
            }
            
            
        }else if givenView == "3"{
            //check third hack's location
            if thirdHack.frame.contains(firstplaceLocationPoint){
                thirdHack.layer.position = firstPlaceholder.layer.position
                firstSelected = true
                rankedHacks["1"] = givenHacks["3"]
                
                
            }else if thirdHack.frame.contains(secondplaceLocationPoint){
                thirdHack.layer.position = secondPlaceholder.layer.position
                secondSelected = true
                rankedHacks["2"] = givenHacks["3"]
                
                
            }else if thirdHack.frame.contains(thirdplaceLocationPoint){
                thirdHack.layer.position = thirdPlaceholder.layer.position
                thirdSelected = true
                rankedHacks["3"] = givenHacks["3"]
               
            }else{
                if rankedHacks["1"] == "3"{
                    //deselect 1
                    rankedHacks["1"] = nil
                    firstSelected = false
                }else if rankedHacks["2"] == "3"{
                    //deselect 1
                    rankedHacks["2"] = nil
                    secondSelected = false
                }else if rankedHacks["3"] == "3"{
                    //deselect 1
                    rankedHacks["3"] = nil
                    thirdSelected = false
                }
                
                
            }
            
        }
        
        if firstSelected && secondSelected && thirdSelected{
            doneButton.isHidden = false
        }else{
            doneButton.isHidden = true
        }
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        for x in rankedHacks{
            print(x)
            
        }
        
        for given in superlatives{
            print(given)
        }
        
        var parameters = Parameters()
        if !nothird && !nosecond{
            parameters = [
                "order":[
                    "1": Int(rankedHacks["1"]!)!,
                    "2": Int(rankedHacks["2"]!)!,
                    "3": Int(rankedHacks["3"]!)!
                ],
                "superlatives": [
                    givenHacks["1"]! : superlatives[givenHacks["1"]!]!,
                    givenHacks["2"]! : superlatives[givenHacks["2"]!]!,
                    givenHacks["3"]! : superlatives[givenHacks["3"]!]!
                ]
            ]
        }else if nosecond && nothird{
            parameters = [
                "order":[
                    "1": Int(rankedHacks["1"]!)!,
                    
                    
                ],
                "superlatives": [
                    givenHacks["1"]! : superlatives[givenHacks["1"]!]!,
                ]
            ]
        }else if nothird{
            parameters = [
                "order":[
                    "1": Int(rankedHacks["1"]!)!,
                    "2": Int(rankedHacks["2"]!)!,
                    
                ],
                "superlatives": [
                    givenHacks["1"]! : superlatives[givenHacks["1"]!]!,
                    givenHacks["2"]! : superlatives[givenHacks["2"]!]!,
                ]
            ]
        }
        
        print(parameters)
        
        API.postRequest(url: URL(string: "https://testapi.hackfsu.com/api/judge/hacks/upload")!, params: parameters) {
            (statuscode) in
            
            if (statuscode == 200) {
                //good
                print("done")
            }else if (statuscode == 400) {
                //good
                print("wrong")
            }
        }
        
    
        //this will clear all information to start a blank slate
        rankedHacks.removeAll()
        superlatives.removeAll()
        superlativeOptions.removeAll()
        
        
        
    }
   

}
