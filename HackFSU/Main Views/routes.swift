//
//  routes.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 2/25/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import Foundation

class routes {
    static let domain = "https://testapi.hackfsu.com"
    static let getUserProfile = domain + "/api/user/get/profile"
    static let registerForPushNoti = domain + "/api/push/register"
    static let getEvents = domain + "/api/user/get/events"
    static let getUpdates = domain + "/api/hackathon/get/updates"
    static let loginURL = domain + "/api/user/login"
    static let newPushNoti = domain + "/api/push/new"
    static let scanURL = domain + "/api/events/scan"
    static let uploadHacks = domain + "/api/judge/hacks/upload"
    static let getHacks = domain + "/api/judge/hacks"
    static let getHackerEvents = domain + "/api/hacker/get/events"
    
    //THIS NEEDS TO BE CHANGED!!!!
    static let getScheduleItems = "https://2017.hackfsu.com/api/hackathon/get/schedule_items"
    static let getMaps = "https://2017.hackfsu.com/api/hackathon/get/maps"
    
}
