//
//  ProfileViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    let context: NSManagedObjectContext = PersistenceService.context
    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
    var yourArray = [User]()
    
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        actionButton.layer.isHidden = true
        
        do {
            yourArray = try context.fetch(fetchRequest)
            
        } catch {
            
        }
        
        name.text = yourArray[0].firstname! + " " + yourArray[0].lastname!
        
        if yourArray[0].groups!.count == 2 {
            self.actionButton.isHidden = true
            position.text = "You are a " + yourArray[0].groups![0] + " and " + yourArray[0].groups![1]
            if yourArray[0].groups!.contains("judge") {
                leftButton.setTitle("Let's Vote!", for: .normal)
            }
            if yourArray[0].groups!.contains("organizer") {
                rightButton.setTitle("Admin Panel", for: .normal)
            }
        }
        else {
            self.leftButton.isHidden = true
            self.rightButton.isHidden = true
            position.text = "You are a " + yourArray[0].groups![0]
            if yourArray[0].groups!.contains("judge") {
                actionButton.setTitle("Let's vote!", for: .normal)
            }
        }
    }
    
    @IBAction func actionFam(_ sender: Any) {
            print("Aye!")
    }
    
    @IBAction func leftAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LetsVoteViewController")
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
    
    @IBAction func returnToMainView(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
}
