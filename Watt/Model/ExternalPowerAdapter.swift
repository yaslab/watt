//
//  ExternalPowerAdapter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2023/06/19.
//

import Foundation

struct ExternalPowerAdapter {
    let wattage: Wattage?
    let voltage: Voltage?
    let current: Current?

    let name: String?
    let manufacturer: String?

    let batteries: [Battery]

    struct Battery {
        let isCharging: Bool
    }
}

extension ExternalPowerAdapter {
    static var empty: ExternalPowerAdapter {
        ExternalPowerAdapter(
            wattage: nil,
            voltage: nil,
            current: nil,
            name: nil,
            manufacturer: nil,
            batteries: []
        )
    }
}

extension ExternalPowerAdapter {
    var isAdapterConnected: Bool {
        return wattage != nil
    }

    var isCharging: Bool {
        return batteries.contains(where: \.isCharging)
    }
}

extension ExternalPowerAdapter {
    func formatVA() -> String? {
        var values: [String] = []

        if let voltage {
            values.append(voltage.format())
        }

        if let current {
            values.append(current.format())
        }

        if values.isEmpty {
            return nil
        }

        return "(" + values.joined(separator: ", ") + ")"
    }

    func formatCharging() -> String {
        if isCharging {
            return "Charging"
        } else {
            return "Not Charging"
        }
    }
}
