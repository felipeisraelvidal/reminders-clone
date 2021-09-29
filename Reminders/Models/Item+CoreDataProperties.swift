//
//  Item+CoreDataProperties.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var isCompleted: Bool
    @NSManaged public var category: Category
    @NSManaged public var createdAt: Date?

}

extension Item : Identifiable {

}
