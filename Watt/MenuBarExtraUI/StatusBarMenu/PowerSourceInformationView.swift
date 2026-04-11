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
        StatusBarMenuLabel(.menuPowerAdapter, icon: { Image(systemName: "powercord.fill") })
            .overlay(alignment: .trailing) {
                let label: LocalizedStringResource =
                    if let current = source.current, current.rawValue > 0 {
                        .menuChargingAt(current: current.format())
                    } else {
                        source.isBatteryCharging ? .menuCharging : .menuConnected
                    }

                Text(label)
                    .foregroundStyle(.secondary)
            }
    }

    private func battery(_ source: PowerAdapter.PowerSource) -> some View {
        StatusBarMenuLabel(.menuBattery, icon: { Image(systemName: source.batteryImageName) })
            .overlay(alignment: .trailing) {
                Text(source.batteryCurrentCapacity.formatted() + "%")
                    .foregroundStyle(.secondary)
            }
    }

    private func timeRemaining(_ time: TimeInMinutes) -> some View {
        StatusBarMenuLabel(.menuTimeRemaining, icon: { Image(systemName: "clock") })
            .overlay(alignment: .trailing) {
                Text(time.format())
                    .foregroundStyle(.secondary)
            }
    }

    private func timeToFullCharge(_ time: TimeInMinutes) -> some View {
        StatusBarMenuLabel(.menuTimeToFullCharge, icon: { Image(systemName: "clock") })
            .overlay(alignment: .trailing) {
                Text(time.format())
                    .foregroundStyle(.secondary)
            }
    }
}
