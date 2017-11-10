//
//  API.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/26/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    class func retriveUserInfo() {
        Alamofire.request("https://api.hackfsu.com/api/user/get/profile", method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            //print(response)
            
            switch response.result {
                case .success(_):
                    self.parseResults(theJSON: JSON(response.result.value!))
                case .failure(_):
                    print("Failed to retrive User Info")
            }
        })
    }
    
    class func parseResults(theJSON: JSON) {
        let email = theJSON["email"].stringValue
        let firstName = theJSON["first_name"].stringValue
        let lastName = theJSON["last_name"].stringValue
        
        print(firstName)
        print(lastName)
        
        let user = User(context: PersistenceService.context)
        user.email = email
        user.firstname = firstName
        user.lastname = lastName
        PersistenceService.saveContext()
    }
    
    class func postRequest(url: URL, params: Parameters?, completion: @escaping (Int) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            let statusCode = response.response?.statusCode
            completion(statusCode!)
        })
    }
}
