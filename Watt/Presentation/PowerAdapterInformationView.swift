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
        var builder = "("

        if let v = voltage, let c = current {
            builder += v.format()
            builder += ", "
            builder += c.format()
        } else if let v = voltage {
            builder += v.format()
        } else if let c = current {
            builder += c.format()
        } else {
            return nil
        }

        builder += ")"

        return builder
    }

    private func format(charging: Bool) -> String {
        if charging {
            return "Charging"
        } else {
            return "Not Charging"
        }
    }
}

struct PowerAdapterInformationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PowerAdapterInformationView(
                viewModel: PowerAdapterInformationViewModel(
                    externalPowerAdapterRepository: ExternalPowerAdapterRepository(
                        ps: PowerSource()
                    )
                )
            )
        }
    }
}
