//
//  routes.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 2/25/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import Foundation

let env = Bundle.main.infoDictionary!["API_ROUTE"] as! String


class routes {
    static let domain = "https://" + env
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
    static let getMaps = domain + "/api/hackathon/get/maps"
    static let getScheduleItems = domain + "/api/hackathon/get/schedule_items"
    
    
}
