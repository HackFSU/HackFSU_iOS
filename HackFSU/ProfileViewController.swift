//
//  ProfileViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import CoreData

var foodItemNumber = 5

class ProfileViewController: UIViewController {
    
    let context: NSManagedObjectContext = PersistenceService.context
    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
    var yourArray = [User]()
    
    @IBOutlet var hackerInfoBottomView: UIView!
    @IBOutlet var judgeInfoBottomView: UIView!
    
    @IBOutlet var judgeandOrgInfoBottomView: UIView!
    @IBOutlet var logoutButton: UIButton!
    
    
    @IBOutlet var QRimage: UIImageView!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.borderWidth = 3
        logoutButton.layer.cornerRadius = 15
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        actionButton.layer.isHidden = true
        
        do {
            yourArray = try context.fetch(fetchRequest)
            
        } catch {
            
        }
        
        name.text = yourArray[0].firstname! + " " + yourArray[0].lastname!
        
        if yourArray[0].groups!.count == 2 {
            hackerInfoBottomView.isHidden = true
            self.actionButton.isHidden = true
            position.text = yourArray[0].groups![0] + " | " + yourArray[0].groups![1]
            if yourArray[0].groups!.contains("judge") {
                leftButton.setTitle("Let's Vote!", for: .normal)
                 judgeInfoBottomView.isHidden = false
            }
            if yourArray[0].groups!.contains("organizer") {
                rightButton.setTitle("Admin Panel", for: .normal)
                judgeandOrgInfoBottomView.isHidden = false
                judgeInfoBottomView.isHidden = true

            }
        }
        else {
            self.leftButton.isHidden = true
            self.rightButton.isHidden = true
            position.text = yourArray[0].groups![0]
            if yourArray[0].groups!.contains("judge") {
                actionButton.setTitle("Let's vote!", for: .normal)
                
                hackerInfoBottomView.isHidden = true
                judgeInfoBottomView.isHidden = false
                judgeandOrgInfoBottomView.isHidden = true
            }
            else{
                actionButton.setTitle("Some Function", for: .normal)
                hackerInfoBottomView.isHidden = false
                judgeandOrgInfoBottomView.isHidden = true
                judgeInfoBottomView.isHidden = true
                
            }
        }
    }
    
    @IBAction func actionFam(_ sender: Any) {
            print("Aye!")
    }
    
    @IBAction func leftAction(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "newJudgeView")
        self.present(vc!, animated: true, completion: nil)

    }
    
    @IBAction func rightAction(_ sender: Any) {
    }
    
    @IBAction func logOut(_ sender: Any) {
        let url = URL(string: "https://api.hackfsu.com")
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
        }
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
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
    
    //only needed to properly return from voting panel
    @IBAction func returnToMainView(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
}

