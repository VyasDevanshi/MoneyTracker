//
//  User+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 17/03/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var country: String?
    @NSManaged public var emailid: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
