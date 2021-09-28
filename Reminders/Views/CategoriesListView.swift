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
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(manager.categories, id: \.id) { category in
                        Text(category.name)
                    }
                }
                .listStyle(InsetGroupedListStyle())
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
                
                if isShowingAlert {
                    AlertView(text: $textEntered, isShowingAlert: $isShowingAlert)
                        .onDisappear {
                            if !textEntered.isEmpty {
                                manager.saveCategory(name: textEntered)
                            }
                        }
                }
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
