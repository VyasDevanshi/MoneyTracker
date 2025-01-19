//
//  Transaction+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 17/03/23.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var account: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var tid: Int32
    @NSManaged public var type: Bool
    @NSManaged public var category: CCategory?

}

extension Transaction : Identifiable {

}
