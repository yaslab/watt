//
//  StatusBarButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarButton: View {
    @Environment(PowerAdapterModel.self) private var powerAdapterModel

    var body: some View {
        Label(title, systemImage: imageName.rawValue)
            .labelStyle(.titleAndIcon)
    }
}

extension StatusBarButton {
    private var adapter: PowerAdapter {
        return powerAdapterModel.value
    }

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
        if adapter.isConnected {
            if adapter.isBatteryCharging {
                return .bolt
            } else {
                return .boltBadgeCheckmark
            }
        } else {
            return .boltSlash
        }
    }
}
