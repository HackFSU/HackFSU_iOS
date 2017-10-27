//
//  LiveFeedViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire

class LiveFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getUserInfo()
    }

    override func viewDidAppear(_ animated: Bool) {

        
        //Trying to delete cookies
        let url = URL(string: "https://2017.hackfsu.com")
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: url!) {
            if cookies.isEmpty {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(vc!, animated: true, completion: nil)
            }
            //for cookie in cookies {
                //cstorage.deleteCookie(cookie)
            //}
        }
    }
    
    func getUserInfo() {
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
