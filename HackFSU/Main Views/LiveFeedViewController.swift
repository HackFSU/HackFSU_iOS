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
        
        //this is for the events that are loaded in for the profile page
        Alamofire.request("https://testapi.hackfsu.com/api/user/get/events", method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(_):
                let eventsJSON = JSON(response.result.value!)["events"]
                for x in eventsJSON.arrayValue{
                    let newdictionary = ["name" : x["name"].stringValue,"time":x["time"].stringValue]
                    
                    if !profileEventsArray.contains(where: {$0 == newdictionary}){
                        profileEventsArray.append(newdictionary)
                    }
                }
                
                print(profileEventsArray)
            case .failure(_):
                print("Failed to retrive User Info")
            }
        })
        
        
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
            
            cellHeight = 175 + Double(cell.latestUpdateDescription.text.count)/3.0
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
