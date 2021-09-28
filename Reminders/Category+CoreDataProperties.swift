//
//  Category+CoreDataProperties.swift
//  Reminders
//
//  Created by Felipe Israel on 27/09/21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String

}

extension Category : Identifiable {

}
