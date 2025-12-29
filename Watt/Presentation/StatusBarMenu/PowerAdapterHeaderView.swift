//
//  PowerAdapterHeaderView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/12.
//

import SwiftUI

struct PowerAdapterHeaderView: View {
    let adapter: PowerAdapter

    var body: some View {
        HStack {
            Text("Power Adapter")
                .font(.headline)

            Spacer()

            Text(connected(adapter.isAdapterConnected))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
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

//#Preview {
//    PowerAdapterHeaderView(adapter: ...)
//}
