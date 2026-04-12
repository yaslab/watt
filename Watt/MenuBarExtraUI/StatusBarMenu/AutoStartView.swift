//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoStartView: View {
    @Environment(AutoStartModel.self) private var autoStartModel

    var body: some View {
        @Bindable var autoStartModel = autoStartModel

        Toggle(isOn: $autoStartModel.isEnabled) {
            StatusBarMenuLabel(.menuLaunchAtLogin, icon: { Image(systemName: "arrow.up.right") })
        }
        .toggleStyle(.switch)
        .onAppear {
            autoStartModel.fetchStatus()
        }
    }
}
