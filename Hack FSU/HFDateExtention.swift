//
//  HFDateExtention.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 12/30/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func timeUntil(date: NSDate) -> CGFloat {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        let components = calendar.components([ .Second ],
            fromDate: NSDate(), toDate: date, options: [])
        let seconds = components.second
        return CGFloat(seconds)
    }
    
    static func timeBetween(date1: NSDate, date2: NSDate) -> CGFloat {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        let components = calendar.components([ .Second ],
            fromDate: date1, toDate: date2, options: [])
        let seconds = components.second
        return abs(CGFloat(seconds))
    }
    
    static func staticTimeHackingStarts() -> NSDate {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        let startingTime = dateFormatter.dateFromString("2017-2-18 0:00")
        return startingTime!
    }
    
    static func staticTimeHackingEnds() -> NSDate {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        let endingTime = dateFormatter.dateFromString("2017-2-19 6:00")
        return endingTime!
    }

    static func timeHasPassed(timeToCheck: NSDate) -> Bool {
        let now = NSDate()
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        let components = calendar.components([ .Second ],
            fromDate: now, toDate: timeToCheck, options: [])
        let seconds = components.second
        
        if seconds > 0 {
            return false
        } else {
            return true
        }
    }
}





//static func timeUntil(date: NSDate) -> CGFloat {
//    let calendar = NSCalendar.autoupdatingCurrentCalendar()
//    calendar.timeZone = NSTimeZone.systemTimeZone()
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.timeZone = calendar.timeZone
//    dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
//    if let endingDate = dateFormatter.dateFromString("2016-2-7 12:00") {
//        let components = calendar.components([ .Second ],
//            fromDate: date, toDate: endingDate, options: [])
//        let seconds = components.second
//        return CGFloat(seconds)
////    }
//    return 0
//}
