//
//  PowerAdapterInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

struct PowerAdapterInformationView: View {
    @StateObject
    var viewModel: PowerAdapterInformationViewModel

    var body: some View {
        VStack {
            if let name = viewModel.adapter.name {
                HStack {
                    Text(name)

                    if let manufacturer = viewModel.adapter.manufacturer {
                        Text("(" + manufacturer + ")")
                    }

                    Spacer()
                }
            }

            if let wattage = viewModel.adapter.wattage {
                HStack {
                    Text(wattage.format())

                    if let text = viewModel.adapter.formatVA() {
                        Text(text)
                    }

                    Spacer()
                }
            }

            HStack {
                Text("Battery:")

                Text(viewModel.adapter.formatCharging())

                Spacer()
            }
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }
}

#Preview {
    PowerAdapterInformationView(
        viewModel: PowerAdapterInformationViewModel(
            externalPowerAdapterRepository: ExternalPowerAdapterRepository(
                ps: PowerSource()
            )
        )
    )
}
