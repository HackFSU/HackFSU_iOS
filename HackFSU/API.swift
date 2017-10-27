//
//  API.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/26/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import Foundation
import Alamofire

class API {
    class func retriveUserInfo() {
        Alamofire.request("https://2017.hackfsu.com/api/user/get/profile", method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            print(response)
        })
    }
    
    class func postRequest(url: URL, params: Parameters?, completion: @escaping (Int) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            let statusCode = response.response?.statusCode
            completion(statusCode!)
        })
    }
}
