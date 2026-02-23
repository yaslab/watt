//
//  PowerAdapter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2023/06/19.
//

import Foundation

/// A power adapter.
struct PowerAdapter {
    let wattage: Wattage?
    let voltage: Voltage?
    let current: Current?

    let name: String?
    let manufacturer: String?

    let sources: [PowerSource]
}

extension PowerAdapter {
    /// A power source, such as a battery.
    struct PowerSource: Identifiable {
        let id: Int
        let state: PowerSourceState
        let batteryCurrentCapacity: Int
        let batteryTimeToEmpty: TimeInMinutes?
        let batteryTimeToFullCharge: TimeInMinutes?
        let isBatteryCharging: Bool
    }
}

extension PowerAdapter {
    var isConnected: Bool {
        return wattage != nil
    }

    var isBatteryCharging: Bool {
        return sources.contains(where: \.isBatteryCharging)
    }
}

extension PowerAdapter {
    func formatWattage() -> String? {
        guard let wattage else {
            return nil
        }

        var value = wattage.format()

        if let voltage, let current {
            value += ", \(voltage.format())⎓\(current.format())"
        }

        return value
    }

    func formatName() -> String? {
        var values: [String] = []

        if let name {
            values.append(name)
        }

        if let manufacturer {
            values.append(manufacturer)
        }

        if values.isEmpty {
            return nil
        } else {
            return values.joined(separator: ", ")
        }
    }
}
