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
        VStack(alignment: .leading) {
            if let name = adapter.name {
                HStack {
                    Text(name)

                    if let manufacturer = adapter.manufacturer {
                        Text("(" + manufacturer + ")")
                    }
                }
            }

            if let wattage = adapter.wattage {
                HStack {
                    Text(wattage.format())

                    if let text = adapter.formatVA() {
                        Text(text)
                    }
                }
            }

            HStack {
                Text("Battery:")

                Text(adapter.formatCharging())
            }
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }
}

#Preview {
    PowerAdapterInformationView(adapter: .mock())
}
