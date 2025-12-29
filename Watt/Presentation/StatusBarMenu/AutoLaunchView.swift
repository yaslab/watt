//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoLaunchView: View {
    @Environment(\.launcherClient) private var launcherClient

    @State private var isAutoLaunchEnabled: Bool = false
    @State private var task: Task<Void, Never>?

    var body: some View {
        Toggle(isOn: $isAutoLaunchEnabled) {
            StatusBarMenuLabel("Launch at login", systemImage: "arrow.up.right")
        }
        .toggleStyle(.switch)
        .onAppear {
            isAutoLaunchEnabled = launcherClient.isEnabled
        }
        .onChange(of: isAutoLaunchEnabled) { oldValue, newValue in
            change(isEnabled: launcherClient.isEnabled, isOn: newValue)
        }
        .onChange(of: launcherClient.isEnabled) { oldValue, newValue in
            change(isEnabled: newValue, isOn: isAutoLaunchEnabled)
        }
    }
}

extension AutoLaunchView {
    private func change(isEnabled: Bool, isOn: Bool) {
        if isEnabled == isOn {
            return
        }

        task?.cancel()

        task = Task {
            do {
                if isOn {
                    try launcherClient.register()
                } else {
                    try await launcherClient.unregister()
                }
            } catch {
                isAutoLaunchEnabled = launcherClient.isEnabled
            }

            task = nil
        }
    }
}
