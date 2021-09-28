//
//  AlertView.swift
//  Reminders
//
//  Created by Felipe Israel on 28/09/21.
//

import SwiftUI

struct AlertView: View {
    @Binding var text: String
    @Binding var isShowingAlert: Bool
    
    @State private var editedText: String = ""
    
    var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text("Add Category")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                    
                    VStack {
                        TextField("Enter text...", text: $editedText) { _ in } onCommit: {
                            text = editedText
                            editedText = ""
                            self.isShowingAlert.toggle()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(UIColor.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding()
                    
                    VStack(spacing: 0) {
                        Divider()

                        HStack {
                            Button(action: {
                                editedText = ""
                                text = ""
                                isShowingAlert.toggle()
                            }) {
                                Text("Cancel")
                                    .font(.system(.body, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            
                            Button(action: {
                                text = editedText
                                editedText = ""
                                isShowingAlert.toggle()
                            }) {
                                Text("Done")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: 350)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
            .padding()
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(text: .constant("Teste"), isShowingAlert: .constant(true))
    }
}
