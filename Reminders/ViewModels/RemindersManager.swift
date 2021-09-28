//
//  RemindersManager.swift
//  Reminders
//
//  Created by Felipe Israel on 27/09/21.
//

import SwiftUI
import CoreData

final class RemindersManager: ObservableObject {
    @Published var categories = [Category]()
    @Published var items = [Item]()
    
    private var context: NSManagedObjectContext
    
    var category: Category? {
        didSet {
            loadItems()
        }
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        loadCategories()
    }
    
    private func save() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
            context.rollback()
        }
        
        loadCategories()
    }
}

// MARK: - Category

extension RemindersManager {
    private func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error load categories: \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    func saveCategory(name: String) {
        let newCategory = Category(context: context)
        newCategory.id = UUID()
        newCategory.name = name
        
        save()
    }
    
    func delete(_ category: Category) {
        context.delete(category)
        save()
    }
}

// MARK: - Item

extension RemindersManager {
    private func loadItems() {
        guard let category = category else {
            assertionFailure("Category cannot be nil")
            return
        }
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.name, ascending: true)
        ]
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Error loading items for \(category.name): \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    func saveItem(){
        context.performAndWait {
            save()
        }
        loadItems()
    }
    
    func delete(_ item: Item) {
        context.performAndWait {
            context.delete(item)
            save()
        }
        
        loadItems()
    }
}
