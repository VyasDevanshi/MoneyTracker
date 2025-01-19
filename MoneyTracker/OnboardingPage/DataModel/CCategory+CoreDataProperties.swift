//
//  CCategory+CoreDataProperties.swift
//  
//
//  Created by TechExtensor PVT LTD on 23/03/23.
//
//

import Foundation
import CoreData


extension CCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CCategory> {
        return NSFetchRequest<CCategory>(entityName: "CCategory")
    }

    @NSManaged public var cid: Int16
    @NSManaged public var name: String?
    @NSManaged public var pid: Int16

}
