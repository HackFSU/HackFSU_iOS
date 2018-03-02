//
//  ProfileViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import SceneKit
import Alamofire
import CoreData
import SwiftyJSON

var reversedEvents = false

var profileEventsArray = [Dictionary<String,String>]()

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileEventsCollectionView: UICollectionView!
    
    var animateButton = false
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
    
    var timer = Timer()
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        reloadScanEventsData()
    }
    
    
    
    
    
    func reloadScanEventsData(){
        profileEventsArray.removeAll()
        
        
        Alamofire.request(routes.getEvents, method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(_):
                let eventsJSON = JSON(response.result.value!)["events"]
                for x in eventsJSON.arrayValue{
                    let newdictionary = ["name" : x["name"].stringValue,"time":x["time"].stringValue]
                        if !profileEventsArray.contains(where: {$0 == newdictionary}){
                        profileEventsArray.insert(newdictionary, at: 0)
                        }

                }
                self.profileEventsCollectionView.reloadData()
                //print(profileEventsArray)
                
            case .failure(_):
                print("Failed to retrive User Info")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        if leftButton.titleLabel?.text == "Admin Panel"{
            leftButton.layer.position = CGPoint(x: (2.5*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/2)
            rightButton.layer.position = CGPoint(x: (3.75*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/2)
        }else{
            leftButton.layer.position = CGPoint(x: (2.5*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/2)
            rightButton.layer.position = CGPoint(x: (3.75*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/2)
        }
        
        reloadScanEventsData()
        //setupProfile()
        
        rightButton.layer.cornerRadius = 20
        leftButton.layer.cornerRadius = 20
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupProfile()
        reloadScanEventsData()
        //grabbing events to insert into collectionview
        profileEventsCollectionView.delegate = self
        profileEventsCollectionView.dataSource = self
        
        
    }

    @IBAction func leftAction(_ sender: UIButton) {
        
        if sender.titleLabel!.text == "Let's Vote!"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "newJudgeView")
            self.present(vc!, animated: true, completion: nil)
            
        }else if sender.titleLabel!.text == "Admin Panel"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "adminPanel")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "adminPanel")
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        let url = URL(string: routes.domain)
        let cstorage = HTTPCookieStorage.shared
        profileEventsArray.removeAll()
        
        if let cookies = cstorage.cookies(for: url!) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
        
        if let result = try? context.fetch(fetchRequest) {
            
            for object in result {
                
                context.delete(object)
            }
            
            
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
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(vc!, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    
    
    //only needed to properly return from voting panel
    @IBAction func returnToMainView(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    
    func setupProfile(){
        
        //gets all the scanned events and puts them into profileEventsArray
        Alamofire.request(routes.getEvents, method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(_):
                let eventsJSON = JSON(response.result.value!)["events"]
                for x in eventsJSON.arrayValue{
                    let newdictionary = ["name" : x["name"].stringValue,"time":x["time"].stringValue]
                    profileEventsArray.insert(newdictionary, at: 0)
                }
                
            case .failure(_):
                print("Failed to retrive events")
            }
        })
        
        
        //logoutButton Visual
        logoutButton.layer.borderWidth = 1.5
        logoutButton.layer.cornerRadius = 15
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logoutButton.layer.backgroundColor = #colorLiteral(red: 0.5397022367, green: 0.1908569932, blue: 0.9999027848, alpha: 1)
        
        
        
        
        var backgroundURL = NSURL()
        
        do {
            yourArray = try context.fetch(fetchRequest)
            
        } catch {
            
        }
        
        backgroundURL = NSURL(string: yourArray[0].qrURL!)!
        name.text = yourArray[0].firstname! + " " + yourArray[0].lastname!
        
        position.text =  ""
        //displaying all the groups the person is a part of
        if yourArray[0].groups![0] != "attendee"{
            position.text = yourArray[0].groups![0]
        }
        for x in yourArray[0].groups!{
            if x != "attendee" && !position.text!.contains(x){
                if position.text!.count < 2{
                    position.text! += x
                }else{
                    position.text! += " | " + x
                }
            }
        }
        
        //displaying hex of person
        position.text! += " | #" + yourArray[0].hex!
        
        //this is to check is a person is both a judge and organizer and sets buttons accordingly
        if yourArray[0].groups!.contains("judge") && yourArray[0].groups!.contains("organizer") {
            leftButton.layer.position = CGPoint(x: (1.25*self.view.bounds.width)/5, y: (5*self.view.bounds.height)/7)
            rightButton.layer.position = CGPoint(x: (3.75*self.view.bounds.width)/5, y: (5*self.view.bounds.height)/7)
            leftButton.setTitle("Let's Vote!", for: .normal)
            rightButton.setTitle("Admin Panel", for: .normal)
            self.rightButton.isHidden = false
            self.leftButton.isHidden = false
            
        }
        else{
            
            //not both an organizer and judge, therefore might be one or the other
            self.rightButton.isHidden = true
            self.leftButton.isHidden = true
            
            
            if yourArray[0].groups!.contains("judge"){
                //person is a judge
                leftButton.setTitle("Let's Vote!", for: .normal)
                
                UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                    self.leftButton.layer.position = CGPoint(x: (2.5*self.view.bounds.width)/5, y: (5*self.view.bounds.height)/7)
                })
                self.leftButton.isHidden = false
                
            }else if yourArray[0].groups!.contains("organizer"){
                //perosn is an Organizer
                
                leftButton.setTitle("Admin Panel", for: .normal)
                
                UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                    self.leftButton.layer.position = CGPoint(x: (2.5*self.view.bounds.width)/5, y: (5*self.view.bounds.height)/7)
                })
                self.leftButton.isHidden = false
                
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



