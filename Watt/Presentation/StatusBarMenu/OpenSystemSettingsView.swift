//
//  OpenSystemSettingsView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/08.
//

import SwiftUI

struct OpenSystemSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.launcherClient) private var launcherClient

    var body: some View {
        Button {
            Task {
                try await Task.sleep(for: .seconds(0.25))
                launcherClient.openSystemSettingsLoginItems()
                dismiss()
            }
        } label: {
            Label("Open System Settings", systemImage: "gear")
                .statusBarMenuButton()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    OpenSystemSettingsView()
}
