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
   
    @IBOutlet var logoutButton: UIButton!
    
    
    @IBOutlet var QRimage: UIImageView!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    //@IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.borderWidth = 3
        logoutButton.layer.cornerRadius = 15
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        leftButton.layer.position = CGPoint(x: (1.25*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/7)
        rightButton.layer.position = CGPoint(x: (3.75*self.view.bounds.width)/5, y: (4.25*self.view.bounds.height)/7)
        
        //actionButton.layer.isHidden = true
    
        var backgroundURL = NSURL()

        do {
            yourArray = try context.fetch(fetchRequest)
            
        } catch {
            
        }
        print(yourArray[0])
        
        backgroundURL = NSURL(string: yourArray[0].qrURL!)!
        name.text = yourArray[0].firstname! + " " + yourArray[0].lastname!
        
        if yourArray[0].groups!.count == 2 {
            
           
            //self.actionButton.isHidden = true
            position.text = yourArray[0].groups![0] + " | " + yourArray[0].groups![1]
            if yourArray[0].groups!.contains("judge") {
                leftButton.setTitle("Let's Vote!", for: .normal)
                
            }
            if yourArray[0].groups!.contains("organizer") {
                rightButton.setTitle("Admin Panel", for: .normal)

            }
        }
        else {
            
            //self.actionButton.isHidden = true
            self.leftButton.isHidden = false
            self.rightButton.isHidden = true
            
            self.leftButton.layer.position = CGPoint(x: (3*self.view.bounds.width)/5, y: (4.5*self.view.bounds.height)/7)
            
            position.text = yourArray[0].groups![0]
            if yourArray[0].groups!.contains("judge") {
                //actionButton.setTitle("Let's vote!", for: .normal)
                
            }
            else{
                
               // actionButton.setTitle("Some Function", for: .normal)
                
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
    
    @IBAction func actionFam(_ sender: Any) {
            print("Aye!")
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

