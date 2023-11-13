//
//  OpenSystemSettingsView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/08.
//

import SwiftUI

struct OpenSystemSettingsView: View {
    @StateObject
    var viewModel: OpenSystemSettingsViewModel

    var body: some View {
        Button(action: viewModel.onClick) {
            Image(systemName: "info.circle")

            Text("Open System Settings")

            Spacer()
        }
        .buttonStyle(.borderless)
        .foregroundColor(.primary)
    }
}

#Preview {
    class MockLauncherManager: LauncherManager {
        var isEnabled: Bool = false
        var isRequiresApproval: Bool = false

        func register() throws {}
        func unregister() throws {}

        func openSystemSettingsLoginItems() {}
    }

    return OpenSystemSettingsView(
        viewModel: OpenSystemSettingsViewModel(
            launcherManager: MockLauncherManager()
        )
    )
}
