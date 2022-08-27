//
//  PowerAdapterInformationViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Foundation

private func string(from string: String?) -> String {
    if let string = string {
        return string
    } else {
        return "-"
    }
}

private func string(from bool: Bool) -> String {
    return bool ? "Yes" : "No"
}

class PowerAdapterInformationViewModel: ObservableObject {
    private weak var ps: PowerSource?

    init(ps: PowerSource?) {
        self.ps = ps
    }

    @Published
    private(set) var isConnected = string(from: false)

    @Published
    private(set) var wattage = string(from: nil)

    @Published
    private(set) var voltage = string(from: nil)

    @Published
    private(set) var current = string(from: nil)

    @Published
    private(set) var name = string(from: nil)

    @Published
    private(set) var manufacturer = string(from: nil)

    @Published
    private(set) var isCharging = string(from: nil)
}

// MARK: - View Events

extension PowerAdapterInformationViewModel {
    func onAppear() {
        if let ps = ps, let details = ps.externalPowerAdapterDetails {
            isConnected = string(from: true)

            wattage = string(from: details.value(forKey: .watts)
                .map { "\($0)W" })

            voltage = string(from: details.value(forKey: .voltage)
                .map { String(format: "%.2fV", Double($0) / 1000.0) })

            current = string(from: details.value(forKey: .current)
                .map { String(format: "%.2fA", Double($0) / 1000.0) })

            name = string(from: details.value(forKey: .name))

            manufacturer = string(from: details.value(forKey: .manufacturer))

            if let sources = ps.powerSources(), sources.contains(where: { $0.value(forKey: .isCharging) }) {
                isCharging = string(from: true)
            } else {
                isCharging = string(from: false)
            }
        } else {
            isConnected = string(from: false)

            wattage = string(from: nil)

            voltage = string(from: nil)

            current = string(from: nil)

            name = string(from: nil)

            manufacturer = string(from: nil)

            isCharging = string(from: nil)
        }
    }
}
