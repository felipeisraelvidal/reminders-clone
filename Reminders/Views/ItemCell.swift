//
//  ItemCell.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct ItemCell: View {
    @ObservedObject var viewModel: ItemCellViewModel
    
    @Binding var isShowingAddItem: Bool
    
    var body: some View {
        HStack {
            Image(systemName: viewModel.item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(viewModel.item.isCompleted ? .red : Color(.lightGray))
                .onTapGesture(perform: viewModel.toggleComplete)
            
            TextField("", text: $viewModel.item.name, onEditingChanged: { _ in }, onCommit: {
                viewModel.saveItem()
                print(viewModel.item.name)
                if viewModel.item.name == "" {
                    isShowingAddItem = false
                }
            })
        }
//        .onDisappear {
//            update(viewModel.item)
//        }
    }
    
//    private func update(_ item: Item) {
//        if item.name.isEmpty {
//            viewModel.deleteItem()
//        } else {
//            viewModel.saveItem()
//        }
//    }
}

struct ItemCell_Previews: PreviewProvider {
    
    static var category: Category = {
        let category = Category(context: PersistenceController.preview.container.viewContext)
        category.id = UUID()
        category.name = "Category 1"
        return category
    }()
    
    static var item: Item = {
        let item = Item(context: PersistenceController.preview.container.viewContext)
        item.id = UUID()
        item.name = "Item 1"
        item.isCompleted = false
        item.category = category
        return item
    }()
    
    static var previews: some View {
        ItemCell(
            viewModel: ItemCellViewModel(
                manager: RemindersManager(
                    context: PersistenceController.preview.container.viewContext
                ),
                item: item
            ),
            isShowingAddItem: .constant(true)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
