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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Trying to delete cookies
//        let cstorage = HTTPCookieStorage.shared
//        if let cookies = cstorage.cookies(for: url) {
//            for cookie in cookies {
//                cstorage.deleteCookie(cookie)
//            }
//        }
    }
    
    @IBAction func loginFam(_ sender: Any) {
        print("yo")
        let parameters: Parameters = [
            "email": emailField.text!,
            "password": passField.text!
        ]
        
        // Both calls are equivalent
        Alamofire.request("https://2017.hackfsu.com/api/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            print(response)
            let statusCode = response.response?.statusCode
            
            if (statusCode == 200) {
                let alertController = UIAlertController(title: "HackFSU", message: "Login successful!", preferredStyle: UIAlertControllerStyle.alert)
                self.success()
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "HackFSU", message: "Login unsuccessful! Fuck", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    func success() {
        Alamofire.request("https://2017.hackfsu.com/api/user/get/profile", method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            print(response)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


