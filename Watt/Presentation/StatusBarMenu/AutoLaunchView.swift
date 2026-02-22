//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoLaunchView: View {
    @Environment(AutoStartModel.self) private var autoStartModel

    var body: some View {
        Toggle(
            isOn: Binding(
                get: { autoStartModel.isEnabled },
                set: { change(isEnabled: autoStartModel.isEnabled, isOn: $0) }
            )
        ) {
            StatusBarMenuLabel("Launch at login", image: Image(systemName: "arrow.up.right"))
        }
        .toggleStyle(.switch)
        .onAppear {
            autoStartModel.fetchStatus()
        }
    }
}

extension AutoLaunchView {
    private func change(isEnabled: Bool, isOn: Bool) {
        if isEnabled == isOn {
            return
        }

        Task {
            do {
                if isOn {
                    try autoStartModel.register()
                } else {
                    try await autoStartModel.unregister()
                }
            } catch {
                autoStartModel.fetchStatus()
            }
        }
    }
}
