//
//  LoginViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire

class LoginVewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var logginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.layer.cornerRadius = 26.0
        passField.layer.cornerRadius = 26.0
        logginButton.layer.cornerRadius = 26.0
        
    }
    
    
    @IBAction func loginFam(_ sender: Any) {
        let parameters: Parameters = [
            "email": emailField.text!,
            "password": passField.text!
        ]
        
        API.postRequest(url: URL(string: "https://api.hackfsu.com/api/user/login")!, params: parameters) {
            (statuscode) in
            
            if (statuscode == 200) {
                API.retriveUserInfo()
                let alertController = UIAlertController(title: "HackFSU", message: "Login successful!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                    //self.dismiss(animated: true, completion: nil)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "initialNotifications")
                    self.present(controller!, animated: true, completion: nil)
                    
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else {
                let alertController = UIAlertController(title: "HackFSU", message: "Login unsuccessful!", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


