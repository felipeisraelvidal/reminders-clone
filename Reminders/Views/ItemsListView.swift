//
//  ItemsListView.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct ItemsListView: View {
    @EnvironmentObject private var manager: RemindersManager
    
    @State private var isShowingAddItem = false
    
    @State private var showsCompleted = true
    
    private var category: Category

    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        List {
            ForEach(manager.items.filter({ !showsCompleted ? $0.isCompleted == false : true }), id: \.id) { item in
                ItemCell(
                    viewModel: ItemCellViewModel(
                        manager: manager,
                        item: item
                    ), isShowingAddItem: $isShowingAddItem
                )
            }
            .onDelete(perform: removeRow(at:))
            
            if isShowingAddItem {
                InputItemCell { name, isCompleted in
                    if !name.isEmpty {
                        self.manager.createNewItem(name: name, isCompleted: isCompleted, category: category)
                    } else {
                        isShowingAddItem = false
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(category.name)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: { withAnimation { isShowingAddItem.toggle() } }) {
                    Image(systemName: "plus.circle.fill")
                    
                    Text("New Item")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                }
                
                Spacer(minLength: 0)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { withAnimation { isShowingAddItem = false } }) {
                    Text("Done")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                }
                .opacity(isShowingAddItem ? 1 : 0)
                .id(UUID())
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showsCompleted.toggle() }) {
                        Label(showsCompleted ? "Hide Completed" : "Show Completed", systemImage: showsCompleted ? "eye.slash" : "eye")
                    }
                } label: {
                    Label("Options", systemImage: "ellipsis.circle")
                }
            }
        }
        .onAppear {
            manager.category = category
        }
    }
    
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let item = manager.items[offset]
            manager.delete(item)
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var category: Category = {
        let newCategory = Category(context: PersistenceController.preview.container.viewContext)
        newCategory.id = UUID()
        newCategory.name = "Category 1"
        return newCategory
    }()
    static var previews: some View {
        NavigationView {
            ItemsListView(category: category)
                .environmentObject(
                    RemindersManager(
                        context: PersistenceController.preview.container.viewContext
                    )
                )
        }
    }
}
