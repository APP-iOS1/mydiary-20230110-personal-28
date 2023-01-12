//
//  View+.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

// MARK: View Extentsions For UI Building
extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
