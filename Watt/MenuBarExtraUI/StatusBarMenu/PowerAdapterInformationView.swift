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
            StatusBarMenuLabel(wattage, image: Image(systemName: "bolt.fill"))

            if let name = adapter.formatName() {
                StatusBarMenuLabel(name, image: Image(systemName: "info.circle"))
                    .foregroundStyle(.secondary)
            }
        } else {
            StatusBarMenuLabel(.menuNotConnected, image: Image(systemName: "bolt.slash.fill"))
        }
    }
}

#if DEBUG
    #Preview {
        PowerAdapterInformationView(adapter: .preview(.connected))
        PowerAdapterInformationView(adapter: .preview(.notConnected))
    }
#endif
