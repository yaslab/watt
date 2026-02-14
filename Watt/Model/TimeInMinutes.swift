//
//  TimeInMinutes.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

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
            return "Calculating..."
        }

        let hour = rawValue / 60
        let minute = rawValue % 60

        var value = ""

        if hour > 0 {
            value += "\(hour)h "
        }

        value += "\(minute)m"

        return value
    }
}
