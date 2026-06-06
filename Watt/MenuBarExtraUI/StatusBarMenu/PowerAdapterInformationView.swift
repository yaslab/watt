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
            StatusBarMenuLabel(wattage, icon: { Image(systemName: "bolt.fill") })

            if let name = adapter.formatName() {
                StatusBarMenuLabel(name, icon: { Image(systemName: "info.circle") })
                    .foregroundStyle(.secondary)
            }
        } else {
            StatusBarMenuLabel(.menuNotConnected, icon: { Image(systemName: "bolt.slash.fill") })
        }
    }
}

#if DEBUG
    #Preview {
        PowerAdapterInformationView(adapter: .preview(.connected))
            .environment(resolver: .preview())
    }

    #Preview {
        PowerAdapterInformationView(adapter: .preview(.notConnected))
            .environment(resolver: .preview())
    }
#endif
