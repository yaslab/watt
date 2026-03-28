//
//  PowerAdapterTests.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/03/28.
//

import Testing

@testable import Watt

struct PowerAdapterTests {

    @Test(arguments: [
        (-1, "battery.0percent"),
        (0, "battery.0percent"),
        (19, "battery.0percent"),
        (20, "battery.25percent"),
        (39, "battery.25percent"),
        (40, "battery.50percent"),
        (59, "battery.50percent"),
        (60, "battery.75percent"),
        (79, "battery.75percent"),
        (80, "battery.100percent"),
        (99, "battery.100percent"),
        (100, "battery.100percent"),
        (101, "battery.100percent"),
    ])
    func batteryImageName_whenNotCharging(capacity: Int, expectedName: String) {
        // Arrange
        let source = PowerAdapter.PowerSource(
            id: 0,
            state: .acPower,
            batteryCurrentCapacity: capacity,
            batteryTimeToEmpty: nil,
            batteryTimeToFullCharge: nil,
            isBatteryCharging: false  // -> not charging
        )

        // Assert
        #expect(source.batteryImageName == expectedName)
    }

    @Test(arguments: [
        (99, "battery.100percent.bolt"),
        (100, "battery.100percent"),
        (101, "battery.100percent"),
    ])
    func batteryImageName_whileCharging(capacity: Int, expectedName: String) {
        // Arrange
        let source = PowerAdapter.PowerSource(
            id: 0,
            state: .acPower,
            batteryCurrentCapacity: capacity,
            batteryTimeToEmpty: nil,
            batteryTimeToFullCharge: nil,
            isBatteryCharging: true  // -> charging
        )

        // Assert
        #expect(source.batteryImageName == expectedName)
    }

}
