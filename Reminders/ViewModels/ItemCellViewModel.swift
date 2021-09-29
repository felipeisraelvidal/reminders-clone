//
//  ItemCellViewModel.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import Foundation

final class ItemCellViewModel: ObservableObject {
    @Published var item: Item
    
    private var manager: RemindersManager
    
    init(manager: RemindersManager, item: Item) {
        self.manager = manager
        self.item = item
    }
    
    func saveItem() {
        if !item.name.isEmpty {
            if item.createdAt == nil {
                item.createdAt = Date()
            }
            
            manager.saveItem()
        } else {
            manager.delete(item)
        }
    }
    
    func deleteItem() {
        manager.delete(item)
    }
    
    func toggleComplete() {
        item.isCompleted.toggle()
        saveItem()
    }
}
