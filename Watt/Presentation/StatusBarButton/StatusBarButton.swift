//
//  StatusBarButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarButton: View {
    private enum ImageName: String {
        case bolt = "bolt.fill"
        case boltSlash = "bolt.slash.fill"
        case boltBadgeCheckmark = "bolt.badge.checkmark.fill"
    }

    @Environment(\.externalPowerAdapterRepository) private var externalPowerAdapterRepository

    @State private var title: String = ""
    @State private var imageName: ImageName = .boltSlash

    var body: some View {
        Label(title, systemImage: imageName.rawValue)
            .labelStyle(.titleAndIcon)
            .onReceive(
                externalPowerAdapterRepository.publisher
                    .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            ) { adapter in
                update(adapter)
            }
    }
}

extension StatusBarButton {
    private func update(_ adapter: ExternalPowerAdapter) {
        if let wattage = adapter.wattage {
            title = wattage.format()
        } else {
            title = ""
        }

        if adapter.isAdapterConnected {
            if let batteries = adapter.batteries, batteries.contains(where: \.isCharging) {
                imageName = .bolt
            } else {
                imageName = .boltBadgeCheckmark
            }
        } else {
            imageName = .boltSlash
        }
    }
}
