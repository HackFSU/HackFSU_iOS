//
//  HFCountdownItem.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 1/11/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import Foundation

class HFCountdownItem {
    
    private var countdownTime:NSDate!
    private var countdownName:String!
    
    init(time: NSDate, name: String) {
        self.countdownName = name
        self.countdownTime = time
    }
    
    func getCountdownTime() -> NSDate {
        return self.countdownTime
    }
    
    func getCountdownName() -> String {
        return self.countdownName
    }
}