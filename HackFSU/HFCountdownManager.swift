//
//  HFCountdownItem.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 1/11/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class HFCountdownManager {
    
    private var arrayOfCountdownTimes = [HFCountdownItem]()
    private var countdownTime:NSDate!
    private var countdownName:String!
    private var currentHackingState:HackingState!
    private var newItemsAvailble:Bool = false
    
    private enum HackingState {
        case HackingNotStarted
        case CurrentlyHacking
        case HackingOver
    }
    
    init() {
        let startingCountdownItem = HFCountdownItem(time: NSDate.staticTimeHackingStarts(), name: "Until Hacking Starts")
        let endingCountdownItem = HFCountdownItem(time: NSDate.staticTimeHackingEnds(), name: "Until Hacking Ends")
        
        arrayOfCountdownTimes.append(startingCountdownItem)
        arrayOfCountdownTimes.append(endingCountdownItem)
        
        self.updateCurentInformationWithCurrentArray()
        
        //callAlamo(NSURL(string: "https://hackfsu.com/api/hackathon/get/countdowns")!)
    }
    
    func callAlamo(url : NSURL) {
        Alamofire.request(.GET, url, encoding: .JSON).validate().responseJSON(completionHandler: {
            response in
            self.parseResults(JSON(response.result.value!), url: url)
            
        })
    }
//
    func parseResults(theJSON : JSON, url: NSURL) {
        for result in theJSON["countdowns"].arrayValue {
            let startTime = result["start"].stringValue
            let endTime = result["end"].stringValue

            arrayOfCountdownTimes.removeAll()
            
            let dateFormatterPrint = NSDateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            let date: NSDate? = dateFormatterPrint.dateFromString(startTime)
            let dateTwo: NSDate? = dateFormatterPrint.dateFromString(endTime)
            
//            print(dateFormatterPrint.stringFromDate(date!))
//            print(dateFormatterPrint.stringFromDate(dateTwo!))
            
            let startingCountdownItem = HFCountdownItem(time: date!, name: "Until Hacking Starts")
            let endingCountdownItem = HFCountdownItem(time: dateTwo!, name: "Until Hacking Ends")
            
            arrayOfCountdownTimes.append(startingCountdownItem)
            arrayOfCountdownTimes.append(endingCountdownItem)
            
            self.updateCurentInformationWithCurrentArray()
            newItemsAvailble = true
            let login = HFCountdownViewController()
            login.checkForNewTimes()
            
        }
    }

    func getHackingStartTime() -> NSDate {
        return self.arrayOfCountdownTimes[0].getCountdownTime()
    }
    
    func getHackingEndTime() -> NSDate {
        return self.arrayOfCountdownTimes[1].getCountdownTime()
    }
    
    func getCurrentCountdownTime() -> NSDate {
        return self.countdownTime
    }
    
    func getCurrentCountdownName() -> String {
        return self.countdownName
    }
    
    func newCountdownItemsAvaible() -> Bool {
        return self.newItemsAvailble
    }
    
    func userGotNewCountdownItems() {
        self.newItemsAvailble = false
    }
    
    func hackingIsOver() -> Bool {
        if self.currentHackingState == .HackingOver {
            return true
        } else {
            return false
        }
    }
    
    func hackingIsCurrent() -> Bool {
        if self.currentHackingState == .CurrentlyHacking {
            return true
        } else {
            return false
        }
    }
    
    func hackingHasntStarted() -> Bool {
        if self.currentHackingState == .HackingNotStarted {
            return true
        } else {
            return false 
        }
    }
    
    func updateCurentInformationWithCurrentArray() {
        
        let firstCountdownItem = arrayOfCountdownTimes[0]
        let secondCountdownItem = arrayOfCountdownTimes[1]
        
        if NSDate.timeHasPassed(firstCountdownItem.getCountdownTime()) == false {
            self.currentHackingState = .HackingNotStarted
        } else if   NSDate.timeHasPassed(firstCountdownItem.getCountdownTime()) == true &&
            NSDate.timeHasPassed(secondCountdownItem.getCountdownTime()) == false {
                self.currentHackingState = .CurrentlyHacking
        } else {
            self.currentHackingState = .HackingOver
        }
        
        if self.currentHackingState == .HackingNotStarted {
            self.countdownTime = firstCountdownItem.getCountdownTime()
            self.countdownName = firstCountdownItem.getCountdownName()
        } else if self.currentHackingState == .HackingOver{
            self.countdownTime = secondCountdownItem.getCountdownTime()
            self.countdownName = "HACKING OVER"
        } else {
            self.countdownTime = secondCountdownItem.getCountdownTime()
            self.countdownName = secondCountdownItem.getCountdownName()
        }
    }
    
    func updateCurentInformationWithCurrentArrayFromStateIncrement() {
        let firstCountdownItem = arrayOfCountdownTimes[0]
        let secondCountdownItem = arrayOfCountdownTimes[1]
        
        if self.currentHackingState == .HackingNotStarted {
            self.countdownTime = firstCountdownItem.getCountdownTime()
            self.countdownName = firstCountdownItem.getCountdownName()
        } else if self.currentHackingState == .HackingOver{
            self.countdownTime = secondCountdownItem.getCountdownTime()
            self.countdownName = "HACKING OVER"
        } else {
            self.countdownTime = secondCountdownItem.getCountdownTime()
            self.countdownName = secondCountdownItem.getCountdownName()
        }
    }
    
    func incrementHackingState() {
        
        if self.currentHackingState == .CurrentlyHacking {
            print("HACKING NOW OVER")
            self.currentHackingState = .HackingOver
        } else if self.currentHackingState == .HackingNotStarted {
            print("NOW CURRENTLY HACKING")
            self.currentHackingState = .CurrentlyHacking
        } else if self.currentHackingState == .HackingOver {
            print("HACKING STILL OVER")
        }
        
    }
    
    
    func loadCountdownEventsFromParse() {
        
    }
}
