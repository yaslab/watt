//
//  PowerAdapterInformationView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

struct PowerAdapterInformationView: View {
    @ObservedObject
    var viewModel: PowerAdapterInformationViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("AC Charger Information")
                .font(.headline)

            Group {
                Row(title: "Connected", value: viewModel.isConnected)

                Row(title: "Wattage", value: viewModel.wattage)

                Group {
                    Row(title: "Voltage", value: viewModel.voltage)

                    Row(title: "Current", value: viewModel.current)
                }
                .foregroundColor(.secondary)
                .padding(.leading)

                Row(title: "Name", value: viewModel.name)

                Row(title: "Manufacturer", value: viewModel.manufacturer)

                Row(title: "Charging", value: viewModel.isCharging)
            }
            .padding(.leading)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

extension PowerAdapterInformationView {
    private struct Row: View {
        let title: String
        let value: String

        var body: some View {
            HStack {
                Text("\(title):")
                Spacer()
                Text(value)
            }
        }
    }
}
