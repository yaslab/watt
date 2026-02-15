//
//  PowerSourceInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/14.
//

import SwiftUI

struct PowerSourceInformationView: View {
    let sources: [PowerAdapter.PowerSource]

    var body: some View {
        ForEach(sources) { source in
            if source.state == .acPower {
                adapter(source)
            }

            battery(source)

            if let time = source.batteryTimeToEmpty, time.isAvailable {
                timeRemaining(time)
                    .foregroundStyle(.secondary)
            }

            if let time = source.batteryTimeToFullCharge, time.isAvailable {
                timeToFullCharge(time)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func adapter(_ source: PowerAdapter.PowerSource) -> some View {
        StatusBarMenuLabel("Power Adapter", systemImage: "powercord.fill")
            .overlay(alignment: .trailing) {
                Text(source.isBatteryCharging ? "Charging" : "Connected")
                    .foregroundStyle(.secondary)
            }
    }

    private func battery(_ source: PowerAdapter.PowerSource) -> some View {
        let image: String

        if source.isBatteryCharging, source.batteryCurrentCapacity != 100 {
            image = "battery.100percent.bolt"
        } else {
            if source.batteryCurrentCapacity < 20 {
                image = "battery.0percent"
            } else if source.batteryCurrentCapacity < 40 {
                image = "battery.25percent"
            } else if source.batteryCurrentCapacity < 60 {
                image = "battery.50percent"
            } else if source.batteryCurrentCapacity < 80 {
                image = "battery.75percent"
            } else {
                image = "battery.100percent"
            }
        }

        return StatusBarMenuLabel("Battery", systemImage: image)
            .overlay(alignment: .trailing) {
                Text("\(source.batteryCurrentCapacity.formatted())%")
                    .foregroundStyle(.secondary)
            }
    }

    private func timeRemaining(_ time: TimeInMinutes) -> some View {
        StatusBarMenuLabel("Time remaining", systemImage: "clock")
            .overlay(alignment: .trailing) {
                Text(time.format())
                    .foregroundStyle(.secondary)
            }
    }

    private func timeToFullCharge(_ time: TimeInMinutes) -> some View {
        StatusBarMenuLabel("Time to full charge", systemImage: "clock")
            .overlay(alignment: .trailing) {
                Text(time.format())
                    .foregroundStyle(.secondary)
            }
    }
}
