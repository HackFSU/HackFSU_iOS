//
//  HFScheduleItem.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 11/19/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import Foundation

class HFScheduleItem {
    
    var scheduleItemTitle:String!
    var scheduleItemSubtitle:String!
    var scheduleItemStartTime:String!
   // var scheduleItemEndTime:String!
    
    init(title: String, subtitle: String, start: String) {
        self.setTitle(title)
        self.setSubtitle(subtitle)
        self.setStartTime(start)
        // self.setEndTime(end)
    }
    
    func setTitle(name: String) {
        self.scheduleItemTitle = name
    }
    
    func setSubtitle(sub: String) {
        self.scheduleItemSubtitle = sub
    }
    
    func setStartTime(time: String) {
        self.scheduleItemStartTime = time
    }
    
//    func setEndTime(time: String) {
//        self.scheduleItemEndTime = time
//    }
    
    func getTitle() -> String {
        return self.scheduleItemTitle
    }
    
    func getSubtitle() -> String {
        return self.scheduleItemSubtitle
    }
    
    func getStartTime() -> String {
        return self.scheduleItemStartTime
    }
    
//    func getEndTime() -> String {
//        return self.scheduleItemEndTime
//    }
//    
}