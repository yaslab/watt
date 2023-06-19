//
//  PowerAdapterHeaderView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/12.
//

import SwiftUI

struct PowerAdapterHeaderView: View {
    @StateObject
    var viewModel: PowerAdapterHeaderViewModel

    var body: some View {
        HStack {
            Text("Power Adapter")
                .font(.headline)

            Spacer()

            Text(connected(viewModel.isConnected))
                .foregroundColor(.secondary)
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }

    private func connected(_ connected: Bool) -> String {
        if connected {
            return "Connected"
        } else {
            return "Not Connected"
        }
    }
}

struct PowerAdapterHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PowerAdapterHeaderView(
                viewModel: PowerAdapterHeaderViewModel(
                    externalPowerAdapterRepository: ExternalPowerAdapterRepository(
                        ps: PowerSource()
                    )
                )
            )
        }
    }
}
