//
//  TimeInMinutes.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

import Foundation

/// The time in minutes.
struct TimeInMinutes: RawRepresentable {
    let rawValue: Int
}

extension TimeInMinutes {
    var isCalculating: Bool {
        rawValue == -1
    }

    var isAvailable: Bool {
        (rawValue > 0) || isCalculating
    }
}

extension TimeInMinutes {
    func format() -> String {
        if isCalculating {
            return String(localized: .menuCalculating)
        }

        let hour = rawValue / 60
        let minute = rawValue % 60

        var value = String(localized: .menuApproximately)
        value += " "

        if hour > 0 {
            value += "\(hour)"
            value += String(localized: .menuHoursShort)
            value += " "
        }

        value += "\(minute)"
        value += String(localized: .menuMinutesShort)

        return value
    }
}
