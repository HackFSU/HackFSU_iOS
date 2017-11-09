//
//  User+CoreDataProperties.swift
//  
//
//  Created by Cameron Farzaneh on 11/9/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?

}
