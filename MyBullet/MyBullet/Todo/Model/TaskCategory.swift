//
//  TaskCategory.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/12.
//

import SwiftUI

enum Category: String, CaseIterable {
    case personal    = "개인"
    case study       = "공부"
    case plan        = "약속"
    case coffeeChat  = "커피챗"
    case habit       = "습관"
    case etc         = "기타"
    
    var color: Color {
        switch self {
        case .personal:
            return Color("Blue")
        case .study:
            return Color("Pink")
        case .plan:
            return Color("Purple")
        case .coffeeChat:
            return Color.brown
        case .habit:
            return Color("Green")
        case .etc:
            return Color("Gray")
        }
    }
}
