//
//  ErrorWrapper.swift
//  Chatz
//
//  Created by Utkarsh Raj on 06/11/24.
//

import SwiftUI

struct ErrorWrapper: Identifiable {
    var id: UUID = UUID()
    let error: Error
    var guidance: String = ""
}
