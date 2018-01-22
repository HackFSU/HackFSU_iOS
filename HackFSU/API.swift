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
            print(response)
            
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
        var g = [String]()
        
        for result in theJSON["groups"].arrayValue {
            g.append(result.stringValue)
        }
        
        let user = User(context: PersistenceService.context)
        user.email = email
        user.firstname = firstName
        user.lastname = lastName
        user.groups = g
        PersistenceService.saveContext()
    }
    
    class func postRequest(url: URL, params: Parameters?, completion: @escaping (Int) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            let statusCode = response.response?.statusCode
            completion(statusCode!)
        })
    }
    
    
    //Function: getSchedule(url: URL) -> Array<Dictionary<String, String>>
    //
    //Description: This function will make the JSON request and parse through the information
    //as well as be able to call 2 separate functions: convertDate() and getDayString()
    //to be able to get the correct date and time, given the fact that they are in UTC
    
    class func getSchedule(url: URL) -> Array<Dictionary<String, String>>{
        var allinfo = [Dictionary<String, String>]()
        
        Alamofire.request(url).responseJSON { response in
            
            //do try catch block to allow us to convert to JSON
            do{
                let OGjson = try JSON(data: response.data!)
            
                //iterating through all the events
                for items in OGjson["schedule_items"]{
                    //assigning eventjson the inside json
                    let eventjson = items.1
                    
                    
                    //accessing additional infomation outside that will be
                    //needed regardless of if there is an end date or not
                    let nameinfo = eventjson["name"].string!
                    let descriptioninfo = eventjson["description"].string!
                    
                    //this is here in case we don't have an end time, so we don't crash the application
                    if let enddate = eventjson["end"].string {
                            //grabbing the correct strings
                        let startString = convertDate(date: eventjson["start"].string!, type: 0)
                        let endString = convertDate(date: enddate, type: 0)
                        
                            //setting the index and range of the times
                            let sIndex = startString.index(startString.startIndex, offsetBy: 11)
                            let eIndex = startString.index(startString.endIndex, offsetBy: -6)
                            let range = sIndex..<eIndex
                        
                            //making new substrings
                            let startTime = startString[range]
                            let endTime = endString[range]
                        
                            //Grabbing Day of the Week
                            let dayofWeek = getDayString(date: startString, type: 0)
                        
                            //making the dictionary
                            let dictionary = ["start":String(describing: startTime), "end":String(describing: endTime), "name":nameinfo,"description":descriptioninfo, "day":dayofWeek]
                        
                            //dictionary check/insertion
                            if !allinfo.contains(where: {$0 == dictionary}){
                                allinfo.append(dictionary)
                            }
                        
                    } else{
                            //grabbing the correct strings
                        let startString = convertDate(date: eventjson["start"].string!, type: 0)
                       
                            //setting the index and range of the times
                            let sIndex = startString.index(startString.startIndex, offsetBy: 11)
                            let eIndex = startString.index(startString.endIndex, offsetBy: -6)
                            let range = sIndex..<eIndex
                        
                            //making new substring
                            let startTime = startString[range]
                            let dayofWeek = getDayString(date: startString, type: 0)
                        
                            //making the dictionary
                            let dictionary = ["start":String(describing: startTime), "name":nameinfo,"description":descriptioninfo, "day":dayofWeek]
                        
                            //dictionary insertion
                            if !allinfo.contains(where: {$0 == dictionary}){
                                allinfo.append(dictionary)
                            }
                    }
                    
                }
                
                //erasing null event to hold place
                allinfo.removeFirst()
                //assigning schedule to global variable schedule
                schedule = allinfo

            }
            catch let error as NSError {
                print(error.localizedDescription)   //THIS IS WILL PROBABLY NEVER HAPPEN UNLESS WE CANNOT RETRIEVE THE JSON
            }
        }
        
        return allinfo
        
    }
    
    //Function: getDayString(date: String) -> String
    //
    //Description: This function will return the day of the week, given the timezone
    class func getDayString(date: String, type: Int) -> String{
        var day = " "
        let s_formatter = DateFormatter()
        if type == 0{
            s_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
             s_formatter.timeZone = TimeZone(abbreviation: "EST")
        }else if type == 1{
            s_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
             s_formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
       
            
        //s_formatter.date(from: date)
        
        let givendate = s_formatter.date(from: date)
         
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: givendate!)
        let weekDay = myComponents.weekday!

        switch weekDay {
        case 1:
                day = "Sunday"
            break
        case 2:
                day = "Monday"
            break
        case 3:
                day = "Tuesday"
            break
        case 4:
                day = "Wednesday"
            break
        case 5:
                day = "Thursday"
            break
        case 6:
                day = "Friday"
            break
        case 7:
                day = "Saturday"
            break
        default:
            break
        }
       
        return day
    }
    
    //Function: convertDate(date: String) -> String
    //
    //Description: This function will converts from UTC to users current time zone
    class func convertDate(date: String, type: Int) -> String{
        var datestring = " "
        //setting up the date formatter
        let s_formatter = DateFormatter()
        if type == 0{
        s_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
        }else if type == 1{
            s_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZZZZZ"
        }
        s_formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let newDate = s_formatter.date(from: date)
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        s_formatter.timeZone =  TimeZone(abbreviation: localTimeZoneAbbreviation)
        
        if type == 0{
        datestring = s_formatter.string(from: newDate!)
        }else if type == 1{
            s_formatter.dateFormat = "E h:mm a"
            datestring = s_formatter.string(from: newDate!)
            
        }
        
        
        
        
        return datestring
    }
    
    
    
}
