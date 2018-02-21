//
//  ProfileViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SwiftyJSON


var profileEventsArray = [Dictionary<String,String>]()

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileEventsCollectionView: UICollectionView!
    
    @IBOutlet var noScan: UILabel!
    let context: NSManagedObjectContext = PersistenceService.context
    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
    var yourArray = [User]()
    
    let refreshControl = UIRefreshControl()
   
   
    @IBOutlet var logoutButton: UIButton!
    
    
    @IBOutlet var QRimage: UIImageView!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
   

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    
    func reloadScanEventsData(){
        profileEventsArray.removeAll()
        
        
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
                self.profileEventsCollectionView.reloadData()
                print(profileEventsArray)
                if profileEventsArray.count != 0{
                    self.noScan.isHidden = true
                }else{
                     self.noScan.isHidden = false
                }
            case .failure(_):
                print("Failed to retrive User Info")
            }
        })
    }
    
    //reload all the scanned events
    override func viewWillDisappear(_ animated: Bool) {
        reloadScanEventsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadScanEventsData()
        profileEventsCollectionView.layer.borderWidth = 1
        profileEventsCollectionView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        refreshControl.addTarget(self, action: #selector(LiveFeedViewController.handleRefresh(refreshControl:)), for: .valueChanged)
        self.profileEventsCollectionView.addSubview(self.refreshControl)
        
        //grabbing events to insert into collectionview
        profileEventsCollectionView.delegate = self
        profileEventsCollectionView.dataSource = self
        
        if profileEventsArray.count == 0{
            noScan.isHidden = false
        }else{
            noScan.isHidden = true
        }
        
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
            case .failure(_):
                print("Failed to retrive User Info")
            }
        })
        
        logoutButton.layer.borderWidth = 3
        logoutButton.layer.cornerRadius = 15
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        leftButton.layer.position = CGPoint(x: (1.25*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/7)
        rightButton.layer.position = CGPoint(x: (3.75*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/7)
        
    
        var backgroundURL = NSURL()

        do {
            yourArray = try context.fetch(fetchRequest)
            
        } catch {
            
        }
        print(yourArray[0])
        
        backgroundURL = NSURL(string: yourArray[0].qrURL!)!
        name.text = yourArray[0].firstname! + " " + yourArray[0].lastname!
        
        if yourArray[0].groups!.count == 2 {
            //two roles, either judge and organizer, or hacker and attendee
            position.text = yourArray[0].groups![0] + " | " + yourArray[0].groups![1]
            if yourArray[0].groups!.contains("judge") && yourArray[0].groups!.contains("organizer") {
                leftButton.setTitle("Let's Vote!", for: .normal)
                rightButton.setTitle("Admin Panel", for: .normal)
                self.rightButton.isHidden = false
                self.leftButton.isHidden = false
                
            }
            else if yourArray[0].groups!.contains("hacker") && yourArray[0].groups!.contains("attendee")   {
                self.rightButton.isHidden = true
                self.leftButton.isHidden = true
            }
            
            
            
        }
        else {
            
            self.leftButton.isHidden = false
            self.rightButton.isHidden = true
            
            self.leftButton.layer.position = CGPoint(x: (2.5*self.view.bounds.width)/5, y: (4.35*self.view.bounds.height)/7)
            
            position.text = yourArray[0].groups![0]
            if yourArray[0].groups!.contains("judge") {
                leftButton.setTitle("Let's vote!", for: .normal)
                
            }
            else{
               leftButton.isHidden = true
            }
        }
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            let backgroundData:NSData? = NSData(contentsOf: backgroundURL as URL)
            DispatchQueue.main.async {
                if (backgroundData != nil) {
                    self.QRimage.image = UIImage(data: backgroundData! as Data)
                }
            }
        }
        
        
        
    }

    @IBAction func leftAction(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "newJudgeView")
        self.present(vc!, animated: true, completion: nil)

    }
    
    @IBAction func rightAction(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "adminPanel")
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        let url = URL(string: "https://testapi.hackfsu.com")
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: url!) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
        
        if let result = try? context.fetch(fetchRequest) {
            
            for object in result {
                
                context.delete(object)
            }
            
            print(result.count)
            do {
                try context.save() // <- remember to put this :)
            } catch {
                print("Could not save context")
                // Do something... fatalerror
            }
        }
        

        
        let alertController = UIAlertController(title: "HackFSU", message: "Logout successful!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(vc!, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        reloadScanEventsData()
        refreshControl.endRefreshing()
    }
    
    
    
    //only needed to properly return from voting panel
    @IBAction func returnToMainView(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
}


/*
 
 COLLECTION VIEW HANDLERS
 
 */
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileEventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileEvent", for: indexPath) as! profileEvents
        
        cell.eventNameLabel.text = profileEventsArray[indexPath.row]["name"]
        cell.timeLabel.text = API.convertDate(date: profileEventsArray[indexPath.row]["time"]!, type: 1)
        
        return cell
    }

    
}


/*CUSTOM CLASS FOR SCAN EVENTS CELL*/
class profileEvents: UICollectionViewCell{
    
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var eventNameLabel: UILabel!
    
    
    
    
}



