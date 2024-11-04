//
//  String+Extensions.swift
//  Chatz
//
//  Created by Utkarsh Raj on 04/11/24.
//

import Foundation


extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
