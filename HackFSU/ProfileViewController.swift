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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            yourArray = try context.fetch(fetchRequest)
            print(yourArray[0].email!)
            //print(yourArray[0].firstname!)
            //print(yourArray[0].lastname!)
            
        } catch {
            
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
