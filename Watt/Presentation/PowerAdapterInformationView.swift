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
            if let name = viewModel.name {
                HStack {
                    Text(name)

                    if let manufacturer = viewModel.manufacturer {
                        Text("(" + manufacturer + ")")
                    }

                    Spacer()
                }
            }

            if let wattage = viewModel.wattage {
                HStack {
                    Text(wattage.format())

                    if let text = format(voltage: viewModel.voltage, current: viewModel.current) {
                        Text(text)
                    }

                    Spacer()
                }
            }

            HStack {
                Text("Battery:")

                Text(format(charging: viewModel.isCharging))

                Spacer()
            }
        }
        .font(.callout)
        .foregroundColor(.secondary)
    }

    private func format(voltage: Voltage?, current: Current?) -> String? {
        var values: [String] = []

        if let voltage {
            values.append(voltage.format())
        }

        if let current {
            values.append(current.format())
        }

        if values.isEmpty {
            return nil
        }

        return "(" + values.joined(separator: ", ") + ")"
    }

    private func format(charging: Bool) -> String {
        if charging {
            return "Charging"
        } else {
            return "Not Charging"
        }
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
