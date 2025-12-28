//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoLaunchView: View {
    @Environment(\.launcherManager) private var launcherManager

    @State private var isAutoLaunchEnabled: Bool = false
    @State private var task: Task<Void, Never>?

    var body: some View {
        Toggle("Launch at login", isOn: $isAutoLaunchEnabled)
            .toggleStyle(.switch)
            //.disabled(task != nil)
            .onAppear {
                isAutoLaunchEnabled = launcherManager.isEnabled
            }
            .onChange(of: isAutoLaunchEnabled) { oldValue, newValue in
                change(isEnabled: launcherManager.isEnabled, isOn: newValue)
            }
            .onChange(of: launcherManager.isEnabled) { oldValue, newValue in
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
                    try launcherManager.register()
                } else {
                    try await launcherManager.unregister()
                }
            } catch {
                isAutoLaunchEnabled = launcherManager.isEnabled
            }

            task = nil
        }
    }
}
