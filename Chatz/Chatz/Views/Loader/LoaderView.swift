//
//  LoaderView.swift
//  Chatz
//
//  Created by Utkarsh Raj on 06/11/24.
//

import SwiftUI

struct LoaderView: View {
    let message: String
    var body: some View {
        HStack {
            ProgressView()
                .tint(.white)
            Text(message)
        }
        .padding(10)
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        
    }
}

#Preview {
    LoaderView(message: "fd")
}
