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

        let hours = rawValue / 60
        let minutes = rawValue % 60

        var value = String(localized: .menuApproximately)
        value += " "

        if hours > 0 {
            value += String(localized: .menuHoursShort(hours: hours))
            value += " "
        }

        value += String(localized: .menuMinutesShort(minutes: minutes))

        return value
    }
}
