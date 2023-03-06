//
//  DateExtension.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation

extension Date {
    // MARK: Date Extension
    func toString(_ format: String, isLocale: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if !isLocale {
            formatter.locale = Locale(identifier: "en_US")
        }
        return formatter.string(from: self)
    }
}
