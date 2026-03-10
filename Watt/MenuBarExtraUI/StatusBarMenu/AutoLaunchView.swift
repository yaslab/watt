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
                set: { autoStartModel.onChange(enabled: $0) }
            )
        ) {
            StatusBarMenuLabel(.menuLaunchAtLogin, image: Image(systemName: "arrow.up.right"))
        }
        .toggleStyle(.switch)
        .onAppear {
            autoStartModel.fetchStatus()
        }
    }
}
