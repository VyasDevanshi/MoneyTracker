//
//  Notes+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 17/03/23.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?

}

extension Notes : Identifiable {

}
