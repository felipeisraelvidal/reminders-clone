//
//  InputItemCell.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct InputItemCell: View {
    @State private var name = ""
    @State private var isCompleted = false
    
    var onCommit: (String, Bool) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(isCompleted ? .red : Color(.lightGray))
                .onTapGesture(perform: { isCompleted.toggle() })
            
            TextField("Enter the item name", text: $name, onEditingChanged: { _ in }, onCommit: {
                onCommit(name, isCompleted)
                name = ""
                isCompleted = false
            })
        }
    }
}

struct InputItemCell_Previews: PreviewProvider {
    static var previews: some View {
        InputItemCell(onCommit: { name, isCompleted in
            print(name, isCompleted)
        })
    }
}
