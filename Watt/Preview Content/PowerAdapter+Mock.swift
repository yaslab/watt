//
//  PowerAdapter+Mock.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/01/24.
//

extension PowerAdapter {
    static func mock() -> PowerAdapter {
        return PowerAdapter(
            wattage: Wattage(rawValue: 60),
            voltage: Voltage(rawValue: 20),
            current: Current(rawValue: 3),
            name: "Mock Adapter",
            manufacturer: "Mock Inc.",
            batteries: [Battery(isCharging: true)]
        )
    }
}
