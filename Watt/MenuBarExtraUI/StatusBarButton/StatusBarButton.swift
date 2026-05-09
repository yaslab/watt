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
        Label(title, systemImage: imageName)
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

    private var imageName: String {
        if adapter.isConnected {
            if adapter.isBatteryCharging {
                "bolt.fill"
            } else {
                "bolt.badge.checkmark.fill"
            }
        } else {
            "bolt.slash.fill"
        }
    }
}
