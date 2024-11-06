//
//  AddNewGroupView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI

struct AddNewGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: Model
    
    @State private var groupSubject: String = ""
    
    
    private func saveGroup() {
        let group = Group(subject: groupSubject)
        model.saveGroup(group: group) { error in
            if let error {
                print(error.localizedDescription)
            }
            dismiss()
            
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Group Subject", text: $groupSubject)
                    
                }
                Spacer()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("New Group")
                        .bold()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        saveGroup()
                    }, label: {
                        Text("Create")
                    })
                }
            })
        }
    }
}

#Preview {
    AddNewGroupView()
        .environmentObject(Model())
}
