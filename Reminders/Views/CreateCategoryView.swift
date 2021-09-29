//
//  CreateCategoryView.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    
    @State private var isShowingErrorAlert = false
    
    var onCreate: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
            }
            .navigationBarTitle("Create Category", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: cancelButton)
                ToolbarItem(placement: .navigationBarTrailing, content: createButton)
            }
            .alert(isPresented: $isShowingErrorAlert) {
                Alert(
                    title: Text("Oops..."),
                    message: Text("Please, enter the category name"),
                    dismissButton: .cancel(Text("OK"))
                )
            }
        }
    }
    
    @ViewBuilder private func cancelButton() -> some View {
        Button(action: cancel) {
            Text("Cancel")
                .font(.system(.body, design: .rounded))
                .foregroundColor(.red)
        }
    }
    
    @ViewBuilder private func createButton() -> some View {
        Button(action: create) {
            Text("Create")
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)
        }
    }
    
    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func create() {
        if !name.isEmpty {
            onCreate(name)
            presentationMode.wrappedValue.dismiss()
        } else {
            isShowingErrorAlert = true
        }
    }
}

struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView(onCreate: { _ in })
    }
}
