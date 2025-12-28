//
//  PowerAdapterHeaderView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/12.
//

import SwiftUI

struct PowerAdapterHeaderView: View {
    @Environment(\.powerAdapterClient) private var powerAdapterClient

    var body: some View {
        HStack {
            Text("Power Adapter")
                .font(.headline)

            Spacer()

            Text(connected(powerAdapterClient.value.isAdapterConnected))
                .foregroundColor(.secondary)
        }
    }
}

extension PowerAdapterHeaderView {
    private func connected(_ connected: Bool) -> String {
        if connected {
            return "Connected"
        } else {
            return "Not Connected"
        }
    }
}

#Preview {
    PowerAdapterHeaderView()
}
