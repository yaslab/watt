//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoLaunchView: View {
    @State
    private var isEnabled = false

    var body: some View {
        HStack {
            Text("Launch at login")
            Spacer()
            Switch(isOn: $isEnabled)
        }
        .onAppear {
            isEnabled = LauncherManager.isEnabled
        }
        .onChange(of: isEnabled) { newValue in
            let success = LauncherManager.setEnabled(newValue)
            if !success {
                Task { @MainActor in
                    isEnabled = !newValue
                }
            }
        }
    }
}
