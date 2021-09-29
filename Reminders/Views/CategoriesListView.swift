//
//  CategoriesListView.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct CategoriesListView: View {
    @EnvironmentObject private var manager: RemindersManager
    
    @State private var isShowingAlert = false
    @State private var textEntered = ""
    
    @State private var isShowingNoDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
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
                
                if isShowingAlert {
                    AlertView(text: $textEntered, isShowingAlert: $isShowingAlert)
                        .onDisappear {
                            if !textEntered.isEmpty {
                                manager.saveCategory(name: textEntered)
                            }
                        }
                }
            }
            .navigationBarTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        withAnimation(.spring()) {
                            isShowingAlert.toggle()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                        
                        Text("New Category")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                    }
                    .opacity(isShowingAlert ? 0 : 1)
                    
                    Spacer()
                }
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
