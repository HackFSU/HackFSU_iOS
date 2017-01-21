//
//  HFFeedViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/22/15.
//  Copyright © 2017 Cam. All rights reserved.
//

import UIKit
import Glyptodon
import Parse
import FlatUIKit
import Alamofire
import SwiftyJSON

class HFFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UI Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewContainerView: UIView!
    
    let apiURL = NSURL(string: "https://cfarzaneh.github.io/sample.json")!
    var titles = [String]()
    
    
    // MARK: Class Variables
    var updateFeedArray:[HFUpdate] = [HFUpdate]()
    var twitterFeedArray:[HFScheduleItem] = [HFScheduleItem]()
    var scheduleFeedArray:[HFScheduleItem] = [HFScheduleItem]()
    
    var fridayFeedArray:[HFScheduleItem] = [HFScheduleItem]()
    var saturdayFeedArray:[HFScheduleItem] = [HFScheduleItem]()
    var sundayFeedArray:[HFScheduleItem] = [HFScheduleItem]()
    var dayArray: [[HFScheduleItem]] = []
    
    var dayOfWeekArray:[String] = [String]()
   // var feedSegmentControl:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.setContentOffset(CGPointZero, animated: false)
        //getUpdatesFromParse()
        //getScheduleItemsFromParse()
        //checkForContent()
        self.feedTableView.rowHeight = UITableViewAutomaticDimension
        self.feedTableView.estimatedRowHeight = 44.0
        feedTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.feedSegmentControl?.tintColor = UIColor._hackRed()
        self.navigationController?.navigationBar.tintColor = .whiteColor()

        // Setting Navigation Bar Title 
        self.navigationItem.title = "HACKFSU"
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary

//        Putting logo in the top bar
//        let logo = UIImage(named: "logo.png") as UIImage?
//        let imageView = UIImageView(image:logo)
//        imageView.frame.size.width = 100;
//        imageView.frame.size.height = 30;
//        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
//        self.navigationItem.titleView = imageView
        
        self.feedTableView.showsVerticalScrollIndicator = false
        
        callAlamo(apiURL)
    }
    
    override func viewWillLayoutSubviews() {
        //checkForContent()
        //callAlamo(apiURL)
    }
    
    override func viewDidAppear(animated: Bool) {
        //getUpdatesFromParse()
        //callAlamo(apiURL)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    func callAlamo(url : NSURL) {
        Alamofire.request(.GET, url, encoding: .JSON).validate().responseJSON(completionHandler: {
        
            response in
            let json = JSON(response.result.value!)
            for result in json["results"].arrayValue {
                let title = result["title"].stringValue
                self.titles.append(title)
            }
            for i in self.titles {
                print(i)
            }
            self.feedTableView.reloadData()
        })
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let update = 0
        let scheudle = 1
        
        switch (self.feedSegmentControl.selectedSegmentIndex) {
        case update:
            return titles.count
        case scheudle:
            return 3
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.feedSegmentControl.selectedSegmentIndex == 0 {
            return 1
        } else {
            if section == 0 {
                return fridayFeedArray.count
            } else if section == 1 {
                return saturdayFeedArray.count
            } else if section == 2 {
                return sundayFeedArray.count
            } else {
                return 0
            }
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let update = 0
        let scheudle = 1
        let twitter = 2
        
        let tempCellColor = UIColor.colorFromHex(0xFBFBFB)
        
        switch (self.feedSegmentControl.selectedSegmentIndex) {
        case update:
            
            let cell:HFUpdateTableViewCell = tableView.dequeueReusableCellWithIdentifier("HFUpdateTableViewCell") as! HFUpdateTableViewCell
            //let update = updateFeedArray[indexPath.section]
            cell.title.text = titles[indexPath.section]
            //cell.subTitle.text = update.getContent()
            cell.subTitle.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. "
            //print(update.getTimestamp())
            //cell.timestamp.text = update.getTimestamp()
            cell.timestamp.text = "temp"
            //print(update.getTimestamp())
            cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: .AllCorners)
            cell.cornerRadius = 3.5
            cell.backgroundColor = UIColor.colorFromHex(0xEDECF3)
            return cell
            
        case scheudle:
            
            let cell:HFScheduleTableViewCell = tableView.dequeueReusableCellWithIdentifier("HFScheduleTableViewCell") as! HFScheduleTableViewCell
            let scheduleItem:HFScheduleItem!
            
            if indexPath.section == 0 {
                scheduleItem = fridayFeedArray[indexPath.row]
            } else if indexPath.section == 1 {
                scheduleItem = saturdayFeedArray[indexPath.row]
            } else if indexPath.section == 2 {
                scheduleItem = sundayFeedArray[indexPath.row]
            } else {
                scheduleItem = fridayFeedArray[indexPath.row]
                // SWITCH TO A DEFAULT ITEM
            }
            
            cell.title.text = scheduleItem.getTitle()
            cell.subtitle.text = scheduleItem.getSubtitle()
            cell.time.text = "\(scheduleItem.getStartTime())"
            
            if indexPath.row == 0 {
                cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: [.TopLeft, .TopRight])
                cell.cornerRadius = 3.5
            } else if indexPath.section == 0 && indexPath.row == fridayFeedArray.count - 1  {
                cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: [.BottomLeft,
                    .BottomRight])
                cell.cornerRadius = 3.5
            } else if indexPath.section == 1 && indexPath.row == saturdayFeedArray.count - 1  {
                cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: [.BottomLeft,
                    .BottomRight])
                cell.cornerRadius = 3.5
            } else if indexPath.section == 2 && indexPath.row == sundayFeedArray.count - 1  {
                cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: [.BottomLeft,
                    .BottomRight])
                cell.cornerRadius = 3.5
            } else {
                cell.configureFlatCellWithColor(tempCellColor, selectedColor: tempCellColor, roundingCorners: .AllCorners)
                cell.cornerRadius = 0
            }
        
            cell.backgroundColor = UIColor.colorFromHex(0xEDECF3)
            
            
            return cell
            
        case twitter: let cell = UITableViewCell(); return cell
            
            
            
            
            
        default: let cell = UITableViewCell(); return cell
        }
        
        
//
//        
//        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("HFUpdateTableViewCell")!
//        
//        
//        
//
//        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 6.5))
        footerView.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        
        return footerView
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:ScheduleHeaderCell = (tableView.dequeueReusableCellWithIdentifier("scheduleHeader") as? ScheduleHeaderCell)!
        cell.backgroundColor = UIColor.colorFromHex(0xEDECF3) // CLEAR
        
        if section == 0 {
            cell.headerLabel.text = "Friday"
        } else if section == 1 {
            cell.headerLabel.text = "Saturday"
        } else if section == 2 {
            cell.headerLabel.text = "Sunday"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.feedSegmentControl.selectedSegmentIndex == 1 {
            return 34.0
        } else {
            return 0.0
        }
    }
    
    
    
    
    @IBAction func feedSegControlValueChanged(sender: AnyObject) {
        self.titles.removeAll()
        callAlamo(apiURL)
        //self.feedTableView.reloadData()
//        checkForContent()
//        getUpdatesFromParse()
//        getScheduleItemsFromParse()
    }
    
    /* checkForContent will check if there is data to be displayed in the view. If not, it will set the correct Glyptodon view. */
    /*
    func checkForContent() {
        let update = 0
        let schedule = 1
        let twitter = 2
        
            switch(self.feedSegmentControl.selectedSegmentIndex) {
            case update: if titles.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Updates. Please Wait.")
            }   else {
                tableViewContainerView.glyptodon.hide()
                feedTableView.alpha = 1.0
                }
            case twitter: if twitterFeedArray.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Tweets. Please Wait.")
            }   else {
                feedTableView.alpha = 1.0
                tableViewContainerView.glyptodon.hide()
                }
            case schedule: if scheduleFeedArray.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Scheudle. Please Wait.")
            }   else {
                feedTableView.alpha = 1.0
                tableViewContainerView.glyptodon.hide()
                }
            default: break
        } // End of Switch
    }
    
    func getUpdatesFromParse() {
        
        
        var updatesArray:[HFUpdate] = [HFUpdate]()
        let query = PFQuery(className: "Update").orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let _ = objects {
                
                self.updateFeedArray.removeAll()
                
                for update in objects! {
                    let newUpdateTitle = update.objectForKey("title") as! String
                    let newUpdateContent = update.objectForKey("subtitle") as! String
                    let tempTimestamp = update.createdAt!
                    let newUpdateTimestamp = self.dateToString(tempTimestamp)
                    
                    let newUpdate = HFUpdate(title: newUpdateTitle, content: newUpdateContent, timestamp: newUpdateTimestamp)
                    updatesArray.append(newUpdate)
                    
                }
                self.updateFeedArray = updatesArray
                self.feedTableView.reloadData()
                self.checkForContent()
            } else {
                print(error)
            }
        }
    }
    
    
    
    func getScheduleItemsFromParse() {
        
        print("merp ")
        
        var scheduleItemsArray:[HFScheduleItem] = [HFScheduleItem]()
        let query = PFQuery(className: "ScheduleItem").orderByAscending("startTime")
        var stateForArrayFill = -1
        query.findObjectsInBackgroundWithBlock { (obejcts, error) -> Void in
            if let _ = obejcts {
                
                self.fridayFeedArray.removeAll()
                self.saturdayFeedArray.removeAll()
                self.sundayFeedArray.removeAll()
                
                for update in obejcts! {
                    let newScheduleItemTitle = update.objectForKey("title") as! String
                    let newScheduleItemSubtitle = update.objectForKey("subtitle") as! String
                    let newScheduleItemStartTime = update.objectForKey("startTime") as! NSDate
                    // let newScheduleItemEndTime = update.objectForKey("endTime") as! NSDate
                    
                    let newScheduleItemStartTimeString = self.timeAsIWantIt(newScheduleItemStartTime)
                    // let newScheduleItemEndTimeString = self.timeAsIWantIt(newScheduleItemEndTime)
                    
                    let newScheduleItem = HFScheduleItem(title: newScheduleItemTitle,
                        subtitle: newScheduleItemSubtitle,
                        start: newScheduleItemStartTimeString)
                    
                    stateForArrayFill = self.getDayOfWeek(newScheduleItemStartTime.dateByAddingTimeInterval(18000))
                    
                    if stateForArrayFill == 0 {
                        self.fridayFeedArray.append(newScheduleItem)
                    } else if stateForArrayFill == 1 {
                        self.saturdayFeedArray.append(newScheduleItem)
                    } else if stateForArrayFill == 2 {
                        self.sundayFeedArray.append(newScheduleItem)
                    }
                    
                    scheduleItemsArray.append(newScheduleItem)
                }
                self.scheduleFeedArray = scheduleItemsArray
                self.feedTableView.reloadData()
                self.checkForContent()
            } else {
                print(error)
            }
        }
    }
    */
    
    func dateToString(date: NSDate) -> String {
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let dateString = dateFormatter.stringFromDate(date)
        let brokenStringArray = dateString.componentsSeparatedByString(",")
        let dayOfWeek = brokenStringArray[0]
        
        let shortDay = longDayToShortDay(dayOfWeek)
        let time = timeAsIWantIt(date)
        return "\(shortDay) \(time)"
    }
    
    func getDayOfWeek(date: NSDate) -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let dateString = dateFormatter.stringFromDate(date)
        let brokenStringArray = dateString.componentsSeparatedByString(",")
        let dayOfWeek = brokenStringArray[0]
        
        switch(dayOfWeek) {
        case "Sunday": return 2
        case "Friday": return 0
        case "Saturday": return 1
        default: return 1
        }
    }
    
    func longDayToShortDay(day: String) -> String {
        
        switch(day) {
        case "Sunday": return "Sun"
        case "Monday": return "Mon"
        case "Tuesday": return "Tues"
        case "Wedneday": return "Wed"
        case "Thursday": return "Thur"
        case "Friday": return "Fri"
        case "Saturday": return "Sat"
        default: return "Sat"
        }
        
    }
    
    func timeAsIWantIt(date: NSDate) -> String {
        //format date
       
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
//        let dateString = dateFormatter.stringFromDate(date.dateByAddingTimeInterval(18000))
        let dateString = dateFormatter.stringFromDate(date)
        let timeComponents = dateString.componentsSeparatedByString(":")
        let hour = Int(timeComponents[0])
        
        return "\(hour!):\(timeComponents[1])"
        
    }
    
}// End of View Controller Class
