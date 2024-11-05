//
//  GroupListContainerView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI

struct GroupListContainerView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: Model
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("New Group")
                })
            }
            
            GroupListView(groups: model.groups)
            Spacer()
        }
        .task {
            do {
                try await model.populateGroups()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            AddNewGroupView()
        })
    }
}

#Preview {
    GroupListContainerView()
        .environmentObject(Model())
}
