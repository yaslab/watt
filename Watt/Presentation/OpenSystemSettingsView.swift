//
//  OpenSystemSettingsView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/08.
//

import SwiftUI

struct OpenSystemSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.launcherManager) private var launcherManager

    var body: some View {
        Button {
            Task {
                try await Task.sleep(for: .seconds(0.25))
                launcherManager.openSystemSettingsLoginItems()
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
