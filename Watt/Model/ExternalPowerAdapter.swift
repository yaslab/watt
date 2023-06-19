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

    let batteries: [Battery]?

    struct Battery {
        let isCharging: Bool
    }
}

extension ExternalPowerAdapter {
    var isAdapterConnected: Bool {
        return wattage != nil
    }

    func format() -> String {
        var text = name ?? "Unknown Adapter"

        if let manufacturer {
            text += " (" + manufacturer + ")"
        }

        return text
    }
}
