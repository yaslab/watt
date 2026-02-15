//
//  PowerAdapterInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

struct PowerAdapterInformationView: View {
    let adapter: PowerAdapter

    var body: some View {
        if let wattage = adapter.formatWattage() {
            StatusBarMenuLabel(wattage, systemImage: "bolt.fill")

            if let name = adapter.formatName() {
                StatusBarMenuLabel(name, systemImage: "info.circle")
                    .foregroundStyle(.secondary)
            }
        } else {
            StatusBarMenuLabel("Not connected", systemImage: "bolt.slash.fill")
        }
    }
}

#if DEBUG
    #Preview {
        PowerAdapterInformationView(adapter: .preview(.connected))
        PowerAdapterInformationView(adapter: .preview(.notConnected))
    }
#endif
