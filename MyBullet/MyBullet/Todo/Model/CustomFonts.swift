//
//  CustomFonts.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

// MARK: Custom Font Extension
enum Hyemin: String {
    case regular
    case bold
    
    var weight: Font.Weight {
        switch self {
        case .regular:
            return .regular
        case .bold:
            return .bold
        }
    }
}

extension View {
    func hyemin(_ size: CGFloat, _ weight: Hyemin) -> some View {
        self
            .font(.custom("IM_Hyemin", size: size))
            .fontWeight(weight.weight)
    }
}
