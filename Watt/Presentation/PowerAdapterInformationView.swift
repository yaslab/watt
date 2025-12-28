//
//  PowerAdapterInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

struct PowerAdapterInformationView: View {
    @Environment(\.externalPowerAdapterRepository) private var externalPowerAdapterRepository

    var body: some View {
        let adapter = externalPowerAdapterRepository.value

        VStack {
            if let name = adapter.name {
                HStack {
                    Text(name)

                    if let manufacturer = adapter.manufacturer {
                        Text("(" + manufacturer + ")")
                    }

                    Spacer()
                }
            }

            if let wattage = adapter.wattage {
                HStack {
                    Text(wattage.format())

                    if let text = adapter.formatVA() {
                        Text(text)
                    }

                    Spacer()
                }
            }

            HStack {
                Text("Battery:")

                Text(adapter.formatCharging())

                Spacer()
            }
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }
}

#Preview {
    PowerAdapterInformationView()
}
