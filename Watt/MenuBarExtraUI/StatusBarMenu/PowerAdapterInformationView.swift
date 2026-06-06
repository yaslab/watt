//
//  PowerAdapterInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

struct PowerAdapterInformationView: View {
    @Environment(InputEventModel.self) private var inputEventModel

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

        if inputEventModel.isOptionKeyPressed, let json = adapter.json() {
            StatusBarMenuButton(.menuCopyAsJSON, icon: { Image(systemName: "document.on.document") }) {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setData(json, forType: .string)
            }
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
