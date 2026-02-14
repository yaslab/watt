//
//  PowerAdapter+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/01/24.
//

import IOKit.ps

extension PowerAdapter {
    enum PreviewType {
        case connected
        case notConnected
    }

    static func preview(_ type: PreviewType) -> PowerAdapter {
        switch type {
        case .connected:
            return PowerAdapter(
                wattage: Wattage(rawValue: 60),
                voltage: Voltage(rawValue: 20_000),
                current: Current(rawValue: 3_000),
                name: "Mock Adapter",
                manufacturer: "Mock Inc.",
                sources: [
                    PowerSource(
                        id: 0,
                        state: .acPower,
                        batteryCurrentCapacity: 100,
                        batteryTimeToEmpty: TimeInMinutes(rawValue: 0),
                        batteryTimeToFullCharge: TimeInMinutes(rawValue: 61),
                        isBatteryCharging: true
                    )
                ]
            )

        case .notConnected:
            return PowerAdapter(
                wattage: nil,
                voltage: nil,
                current: nil,
                name: nil,
                manufacturer: nil,
                sources: [
                    PowerSource(
                        id: 0,
                        state: .batteryPower,
                        batteryCurrentCapacity: 75,
                        batteryTimeToEmpty: TimeInMinutes(rawValue: 61),
                        batteryTimeToFullCharge: TimeInMinutes(rawValue: 0),
                        isBatteryCharging: false
                    )
                ]
            )
        }
    }
}
