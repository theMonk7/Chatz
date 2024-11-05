//
//  GroupListView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 05/11/24.
//

import SwiftUI

struct GroupListView: View {
    let groups: [Group]
    var body: some View {
        List(groups) { group in
            NavigationLink {
                GroupDetailView(group: group)
            } label: {
                HStack {
                    Image(systemName: "person.2")
                    Text(group.subject)
                }
            }

        }
    }
}

#Preview {
    GroupListView(groups: [])
}
