//
//  PowerAdapter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2023/06/19.
//

import Foundation

struct PowerAdapter {
    let wattage: Wattage?
    let voltage: Voltage?
    let current: Current?

    let name: String?
    let manufacturer: String?

    let batteries: [Battery]?

    struct Battery {
        let isCharging: Bool
    }
}

extension PowerAdapter {
    var isAdapterConnected: Bool {
        return wattage != nil
    }

    var isCharging: Bool {
        guard let batteries else {
            return false
        }
        return batteries.contains(where: \.isCharging)
    }
}

extension PowerAdapter {
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
