//
//  CategoriesListView.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct CategoriesListView: View {
    @EnvironmentObject private var manager: RemindersManager
    
    @State private var textEntered = ""
    
    @State private var isShowingNoDeleteAlert = false
    @State private var isCreatingNewCategory = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.categories, id: \.id) { category in
                    NavigationLink(
                        destination: ItemsListView(category: category)
                    ) {
                        HStack {
                            Text(category.name)
                            
                            Spacer(minLength: 0)
                            
                            Text("\(category.items?.count ?? 0)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: removeRow(at:))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        withAnimation(.spring()) {
                            isCreatingNewCategory.toggle()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                        
                        Text("New Category")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $isCreatingNewCategory) {
                CreateCategoryView(onCreate: { name in
                    manager.saveCategory(name: name)
                })
            }
            .alert(isPresented: $isShowingNoDeleteAlert) {
                Alert(
                    title: Text("Delete Failed"),
                    message: Text("There are items currently attached to this category."),
                    dismissButton: .cancel(Text("OK"))
                )
            }
        }
    }
    
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let category = manager.categories[offset]
            
            if manager.canDelete(category) {
                manager.delete(category)
            } else {
                isShowingNoDeleteAlert = true
            }
        }
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView()
            .environmentObject(RemindersManager(context: PersistenceController.preview.container.viewContext))
    }
}
