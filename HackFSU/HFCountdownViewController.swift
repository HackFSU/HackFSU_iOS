//
//  HFCountdownViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 12/30/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

var globalEventTimeLeft:CGFloat = NSDate.timeUntil(NSDate())
var countdownManager = HFCountdownManager()

class HFCountdownViewController: UIViewController {

    @IBOutlet weak var countDownCircle: CounterView!
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBOutlet weak var secondsTimerLabel: UILabel!
    
    @IBOutlet weak var minutesTimerLabel: UILabel!
    
    @IBOutlet weak var hoursTimeLabel: UILabel!
    
    var timer = NSTimer()
    var timerCount:Int!
    var timerIsRunning = false
    let shapeArray:[String] = ["lightning", "triangle", "line", "cross"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        
        // Setting Navigation Bar Title
        self.navigationItem.title = countdownManager.getCurrentCountdownName()
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary
        
        runClock()
    }
    
    func runClock() {
        timerCount = Int(NSDate.timeUntil(countdownManager.getCurrentCountdownTime()))
        counting()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HFCountdownViewController.counting), userInfo: nil,repeats: true)
        timerIsRunning = true
    }
    
    override func viewDidAppear(animated: Bool) {
        if timerIsRunning == false {
           runClock()
        } else {
            countdownManager.loadCountdownEventsFromParse()
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let random = Int(arc4random_uniform(4))
        let image = shapeArray[random]
        self.shapeImage.image = UIImage(named: image )

    }
    
    func checkForNewTimes() {
        if countdownManager.newCountdownItemsAvaible() == true {
            timerCount = Int(NSDate.timeUntil(countdownManager.getCurrentCountdownTime()))
            self.navigationItem.title = countdownManager.getCurrentCountdownName()
            countdownManager.userGotNewCountdownItems()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func counting() {
        
        
        
        checkForNewTimes()
        
        let secondsInAMinute = 60
        let secondsInAnHour = 60 * 60
        
        timerCount = timerCount - 1
        globalEventTimeLeft = CGFloat(timerCount)
        
        self.countDownCircle.setNeedsDisplay()
        
        if timerCount < 0 {
            
            timerCount = 0
            self.navigationItem.title = "HACKING OVER"
            secondsTimerLabel.text = "00"
            minutesTimerLabel.text = "00"
            hoursTimeLabel.text = "00"
            timer.invalidate()
            timerIsRunning = false
        } else if timerCount == 0 {
            
            secondsTimerLabel.text = "00"
            minutesTimerLabel.text = "00"
            hoursTimeLabel.text = "00"
            
            if countdownManager.hackingIsOver() == true {
                self.navigationItem.title = "HACKING OVER"
                secondsTimerLabel.text = "00"
                minutesTimerLabel.text = "00"
                hoursTimeLabel.text = "00"
                timer.invalidate()
            } else if countdownManager.hackingIsCurrent() == true {
                print("BRING ME DA MONEY")
                countdownManager.incrementHackingState()
                self.navigationItem.title = "HACKING OVER"
                secondsTimerLabel.text = "00"
                minutesTimerLabel.text = "00"
                hoursTimeLabel.text = "00"
                timer.invalidate()
                timerIsRunning = false
            } else if countdownManager.hackingHasntStarted() {
                globalEventTimeLeft = NSDate.timeBetween(countdownManager.getHackingStartTime(), date2: countdownManager.getHackingEndTime())
                countdownManager.incrementHackingState()
                countdownManager.updateCurentInformationWithCurrentArrayFromStateIncrement()
                self.navigationItem.title = countdownManager.getCurrentCountdownName()
                timerCount = Int(NSDate.timeUntil(countdownManager.getCurrentCountdownTime()))
            }
        }
        else if timerCount < 60 {
            
            hoursTimeLabel.text = "00"
            minutesTimerLabel.text = "00"
            
            if timerCount < 10 {
                secondsTimerLabel.text = "0\(timerCount)"
            } else {
                secondsTimerLabel.text = "\(timerCount)"
            }
            
        } else if timerCount < secondsInAnHour {
            let minutes = timerCount / 60
            let seconds = timerCount - ( minutes * 60 )
            
            hoursTimeLabel.text = "00"
            
            if minutes < 10 {
                minutesTimerLabel.text = "0\(minutes)"
            } else {
                minutesTimerLabel.text = "\(minutes)"
            }
            
            if seconds < 10 {
                secondsTimerLabel.text = "0\(seconds)"
            } else {
                secondsTimerLabel.text = "\(seconds)"
            }
        } else {
            let hours = timerCount / secondsInAnHour
            let minutes = ( timerCount - ( hours * secondsInAnHour ) ) / secondsInAMinute
            let seconds = timerCount - (hours * secondsInAnHour) - ( minutes * secondsInAMinute )
            
            
            
            if hours < 10 {
                hoursTimeLabel.text = "0\(hours)"
            } else {
                hoursTimeLabel.text = "\(hours)"
            }
            
            if minutes < 10 {
                minutesTimerLabel.text = "0\(minutes)"
            } else {
                minutesTimerLabel.text = "\(minutes)"
            }
            
            if seconds < 10 {
                secondsTimerLabel.text = "0\(seconds)"
            } else {
                secondsTimerLabel.text = "\(seconds)"
            }
        }
    } // End of Counting()

//    func getNextCountdownItemFromParse() -> (String, NSDate) {
//        
//        let query = PFQuery(className: "CountdownItem").orderByAescending("time")
//        
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if let _ = objects {
//                
//                for items in objects! {
//                    
//                    
//                    
//                }
//                
//                
//            } else {
//                
//                // error handle if no events pulled
//                
//            }
//        }
//    }

}
