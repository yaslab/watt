//
//  StatusBarButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarButton: View {
    @Environment(\.powerAdapterClient) private var powerAdapterClient

    @Binding var adapter: PowerAdapter

    var body: some View {
        Label(title, systemImage: imageName.rawValue)
            .labelStyle(.titleAndIcon)
            .task {
                let publisher = powerAdapterClient.publisher
                    .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)

                for await newValue in publisher.values {
                    adapter = newValue
                }
            }
    }
}

extension StatusBarButton {
    private var title: String {
        if let wattage = adapter.wattage {
            return wattage.format()
        } else {
            return ""
        }
    }

    private enum ImageName: String {
        case bolt = "bolt.fill"
        case boltSlash = "bolt.slash.fill"
        case boltBadgeCheckmark = "bolt.badge.checkmark.fill"
    }

    private var imageName: ImageName {
        if adapter.isAdapterConnected {
            if let batteries = adapter.batteries, batteries.contains(where: \.isCharging) {
                return .bolt
            } else {
                return .boltBadgeCheckmark
            }
        } else {
            return .boltSlash
        }
    }
}
