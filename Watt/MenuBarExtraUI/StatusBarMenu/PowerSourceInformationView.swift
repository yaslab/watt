//
//  PowerSourceInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/14.
//

import SwiftUI

struct PowerSourceInformationView: View {
    @Environment(InputEventModel.self) private var inputEventModel

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

            if inputEventModel.isOptionKeyPressed, let json = source.json() {
                StatusBarMenuButton(.menuCopyAsJSON, icon: { Image(systemName: "document.on.document") }) {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setData(json, forType: .string)
                }
            }
        }
    }

    private func adapter(_ source: PowerAdapter.PowerSource) -> some View {
        StatusBarMenuLabel(.menuPowerAdapter, icon: { Image(systemName: "powercord.fill") })
            .overlay(alignment: .trailing) {
                Text(source.isBatteryCharging ? .menuCharging : .menuConnected)
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

#if DEBUG
    #Preview {
        PowerSourceInformationView(
            sources: PowerAdapter.preview(.notConnected).sources
        )
        .environment(
            resolver: PreviewHelper.resolver(keyPressed: false)
        )
    }

    #Preview {
        PowerSourceInformationView(
            sources: PowerAdapter.preview(.connected).sources
        )
        .environment(
            resolver: PreviewHelper.resolver(keyPressed: true)
        )
    }

    private enum PreviewHelper {
        static func resolver(keyPressed: Bool) -> DIResolver {
            return .preview(
                inputEventMonitor: InputEventMonitorPreviewImpl(isOptionKeyPressed: keyPressed)
            )
        }
    }
#endif
