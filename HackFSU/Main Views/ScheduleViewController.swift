//
//  ScheduleViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire

var schedule: [[String:String]] = [[:]]
var height = 110.0


class ScheduleViewController: UIViewController {
    @IBOutlet var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //schedule gets added in live Feed view so we don't need to do anything here
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        
  
    }
  
    
    
    
    
}


/*
 all necessary tableview data handlers
 */
extension ScheduleViewController:  UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! ScheduleCustomCell
        
        cell.eventNameLabel.text = schedule[indexPath.row]["name"]
        cell.eventDurationLabel.text = " "
        cell.eventDescriptionLabel.text = schedule[indexPath.row]["description"]
        if cell.eventDescriptionLabel.text!.count > 400 {
            //resize cell
            height = 110.0 + (Double(cell.eventDescriptionLabel.text!.count)/2.1)
           
            
            cell.eventDescriptionLabel.numberOfLines = cell.eventDescriptionLabel.numberOfLines + 13
            
        }else if cell.eventDescriptionLabel.text!.count > 161 {
            //resize cell
           
            height = height + (Double(cell.eventDescriptionLabel.text!.count)/1.7)
            
            cell.eventDescriptionLabel.numberOfLines = 10
            
        }else if cell.eventDescriptionLabel.text!.count > 120 {
            //resize cell
            height = 110.0 + (Double(cell.eventDescriptionLabel.text!.count)/2.5)
            
            cell.eventDescriptionLabel.numberOfLines = 6
            
        }else if cell.eventDescriptionLabel.text!.count > 70 {
           
            //resize cell
            height = height + (Double(cell.eventDescriptionLabel.text!.count)/2.5)
            if height < 100 {
                 height = height + (Double(cell.eventDescriptionLabel.text!.count)/3)
            }
            
            cell.eventDescriptionLabel.numberOfLines = 6
            
        }else if cell.eventDescriptionLabel.text!.count < 50 && cell.eventDescriptionLabel.text!.count > 30  {
            height = 100
            cell.eventDescriptionLabel.numberOfLines = 3
            
            
        }
        else if cell.eventDescriptionLabel.text!.count < 30 && cell.eventDescriptionLabel.text!.count > 2  {
            height = 90
            cell.eventDescriptionLabel.numberOfLines = 3
            
            
        }else if cell.eventDescriptionLabel.text!.count < 2 {
            height = 70
            cell.eventDescriptionLabel.numberOfLines = 1
           
        }else{
            height = 110
            cell.eventDescriptionLabel.numberOfLines = 3
        }
 
        if schedule[indexPath.row]["day"] == "Thursday"{
            cell.dayIdentifierCircle.image = #imageLiteral(resourceName: "ThursdayCirclePink")
            
        } else if schedule[indexPath.row]["day"] == "Friday"{
            cell.dayIdentifierCircle.image = #imageLiteral(resourceName: "FridayCircleMint")
            
        }else if schedule[indexPath.row]["day"] == "Saturday"{
            cell.dayIdentifierCircle.image = #imageLiteral(resourceName: "SaturdayCirclePurple")
            
        }else if schedule[indexPath.row]["day"] == "Sunday"{
            cell.dayIdentifierCircle.image = #imageLiteral(resourceName: "SundayCirclePink")
            
        }
        
        //assigning strings
        let startTime = schedule[indexPath.row]["start"]!
        
        let checkforMilitaryTime = startTime
        
        //setting indexes to get substrings
        let eMilitaryIndex = startTime.index(startTime.endIndex, offsetBy: -6)
        let minuteIndex = startTime.index(startTime.startIndex, offsetBy: 3)
        let eMinuteIndex = startTime.index(startTime.endIndex, offsetBy: -3)
        
        
        let range = startTime.startIndex..<eMilitaryIndex
        let mrange = minuteIndex..<eMinuteIndex
        let mNumber = Int(checkforMilitaryTime[range])!
        let minutes = String(startTime[mrange])
        
        
        //
        //checking for all Duration conditions
        //
        if let endTime = schedule[indexPath.row]["end"] {
            let startHourChecker = Int(startTime[range])!
            let endHourChecker = Int(endTime[range])!
            let startMinuteChecker = Int(startTime[mrange])!
            var endMinuteChecker = Int(endTime[mrange])!
            
            
            if endHourChecker-startHourChecker < 1 {
                //event lasts less than an hour
                
                if endMinuteChecker == startMinuteChecker {
                    cell.eventDurationLabel.text = "1 Hour"
                }else{
                    cell.eventDurationLabel.text = (String(endMinuteChecker - startMinuteChecker)+" Minutes")
                }
                
            } else if endHourChecker-startHourChecker == 1{
                //event lasts 1 hour
                
                if startMinuteChecker > endMinuteChecker{
                    
                    endMinuteChecker = endMinuteChecker + startMinuteChecker
                }
                if endMinuteChecker - startMinuteChecker == 0{
                    cell.eventDurationLabel.text = "1 Hour"
                    
                }else {
                    cell.eventDurationLabel.text = "1 Hour and " + String(endMinuteChecker - startMinuteChecker) + " Minutes"
                }
                
            } else if endHourChecker-startHourChecker > 1{
                //event lasts more than an hour
                
                if startMinuteChecker > endMinuteChecker{
                    
                    endMinuteChecker = endMinuteChecker + startMinuteChecker
                }
                if endMinuteChecker - startMinuteChecker == 0{
                    cell.eventDurationLabel.text = String(endHourChecker-startHourChecker) + " Hours"
                } else{
                    cell.eventDurationLabel.text = String(endHourChecker-startHourChecker) + " Hours and " + String(endMinuteChecker - startMinuteChecker) + " Minutes"
                }
            }
            
            
        }
        
        
        //
        //checking for all Time conditions
        //
        if mNumber>12 {
            //It's past 12 in Military Time so display accordingly
            cell.eventTimeLabel.text = (String(mNumber % 12) + ":" + minutes + " PM")
        }else if mNumber == 0 {
            //It's 12 AM in Military Time so display accordingly
            cell.eventTimeLabel.text = ("12:" + minutes + " AM")
        }else if mNumber == 12 {
            //It's 12 PM in Military Time so display accordingly
            cell.eventTimeLabel.text = ("12:" + minutes + " PM")
        }else{
            //It's before 12 PM in Military Time so display accordingly
            cell.eventTimeLabel.text = (String(mNumber % 12) + ":" + minutes + " AM")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(height)
    }
    
    
    
    
}

