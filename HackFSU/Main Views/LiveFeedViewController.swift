//
//  LiveFeedViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Modified by Andres Ibarra on 1/19/18
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

var loadedLiveFeed = false
var liveFeedNotifications = [Dictionary<String, String>]()

class LiveFeedViewController: UIViewController {
   
    @IBOutlet var liveFeedBanner: UIImageView!
    
    var cellHeight = 150.00
    var latestUpdate = Dictionary<String, String>()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(LiveFeedViewController.handleRefresh(refreshControl:)), for: .valueChanged)
    
        self.tableView.addSubview(self.refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = CGFloat(2)

        addLiveInfomationFirst()
        
        //print(UIDevice.current.modelName)
        
        liveFeedBanner.layer.position = CGPoint(x: (0.565*self.view.bounds.height)/4, y: (0.5*self.view.bounds.height)/4)
        
        //Andres for Schedule
        self.navigationController?.navigationBar.isHidden = true
        schedule = API.getSchedule(url: URL(string:"https://2017.hackfsu.com/api/hackathon/get/schedule_items")!)
        //
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if (userNotLoggedIn == true) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(vc!, animated: true, completion: nil)
        }
        else {

            API.retriveUserInfo()
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            do {
                let _ = try PersistenceService.context.fetch(fetchRequest)
            } catch {
                
            }
        }
    }
    
    var userNotLoggedIn: Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let count = try PersistenceService.context.count(for: fetchRequest)
            return count == 0 ? true : false
        } catch {
            return true
        }
    }
    
    //only needed to properly return from login
    @IBAction func returnToMainViewFromLogin(unwindSegue: UIStoryboardSegue) {
        
    }

    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        addLiveInfomationFirst()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

}
    
extension LiveFeedViewController:   UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return liveFeedNotifications.count
    }
    
   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        let footerView = UIView()
        footerView.backgroundColor =  UIColor.gray
        footerView.alpha = 0.25
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            print(indexPath.section)
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainNotificationCell") as! LiveFeedMainCell
            
            cell.latestUpdateTitle.text = latestUpdate["title"]!
            cell.latestUpdateTime.text = latestUpdate["submitted_time"]!
            cell.latestUpdateDescription.text = latestUpdate["description"]
            
            cellHeight = 150 + Double(cell.latestUpdateDescription.text.count)/3.0
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveFeedCell") as! LiveFeedTableViewCell

        
        cell.titleLabel.text = liveFeedNotifications[indexPath.section]["title"]!
        cell.timeLabel.text = liveFeedNotifications[indexPath.section]["submitted_time"]!
        
        cell.descriptionLabel.text = liveFeedNotifications[indexPath.section]["description"]!
        
        
        
        if cell.descriptionLabel.text!.count > 400 {
            //resize cell
            cellHeight =  (Double(cell.descriptionLabel.text!.count)/4.7)
            
            cell.descriptionLabel.numberOfLines = cell.descriptionLabel.numberOfLines + 13
            
        }else if cell.descriptionLabel.text!.count > 150 {
            //resize cell
            
            cellHeight = 110 + (Double(cell.descriptionLabel.text!.count)/5)
            
            cell.descriptionLabel.numberOfLines = 10
            
        }else if cell.descriptionLabel.text!.count > 70 {
            
            //resize cell
             cellHeight = 110 + (Double(cell.descriptionLabel.text!.count)/10)
            
            
            cell.descriptionLabel.numberOfLines = 6
            
        }else if cell.descriptionLabel.text!.count < 50 && cell.descriptionLabel.text!.count > 35  {
            cellHeight = 110
            cell.descriptionLabel.numberOfLines = 3
            
            
        }
        else if cell.descriptionLabel.text!.count < 35 && cell.descriptionLabel.text!.count > 2  {
            cellHeight = 80
            cell.descriptionLabel.numberOfLines = 3
            
            
        }else if cell.descriptionLabel.text!.count < 2 {
            cellHeight = 50
            cell.descriptionLabel.numberOfLines = 1
            
        }else{
            cellHeight = 110
            cell.descriptionLabel.numberOfLines = 3
        }
     
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        
        
        
        return cell
    }
    
    
    //Needs to be in this file because if not it won't load up when the view does
    func addLiveInfomationFirst(){
        
        var allinfo = [Dictionary<String, String>]()
        
        Alamofire.request(URL(string: "https://2017.hackfsu.com/api/hackathon/get/updates")!).responseJSON { response in
            do{
                let OGjson = try JSON(data: response.data!)
                //populate the info
                
                for items in OGjson["updates"]{
                    //assigning eventjson the inside json
                    let updatejson = items.1
                    //print(updatejson)
                    
                    let givenContent = updatejson["content"].string!
                    let givenTitle = updatejson["title"].string!
                    let convertedTime = API.convertDate(date: updatejson["submit_time"].string!, type: 1)
                    let dayofWeek = API.getDayString(date: updatejson["submit_time"].string!, type: 1)
                    
                    let dictionary = ["submitted_time":String(describing: convertedTime), "title":givenTitle,"description":givenContent, "day":dayofWeek]
                    
                    //dictionary insertion
                    if !allinfo.contains(where: {$0 == dictionary}){
                        allinfo.append(dictionary)
                    }
                    
                    //assigning livefeed to global variable liveFeedNotifications
                    liveFeedNotifications = allinfo
                    
                }
                 loadedLiveFeed = true
                self.latestUpdate = liveFeedNotifications[0]
                
                liveFeedNotifications.removeFirst()
                

                
                 self.tableView.reloadData()
            }
            catch let error as NSError {
                print(error.localizedDescription)   //THIS IS WILL PROBABLY NEVER HAPPEN UNLESS WE CANNOT RETRIEVE THE JSON
            }
            
        }
        
    }

}



public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

