//
//  OpenSystemSettingsView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/08.
//

import SwiftUI

struct OpenSystemSettingsView: View {
    @Environment(AutoStartModel.self) private var autoStartModel

    var body: some View {
        StatusBarMenuButton("Open System Settings...", image: Image(systemName: "gear")) {
            autoStartModel.openSystemSettingsLoginItems()
        }
    }
}

#Preview {
    OpenSystemSettingsView()
        .environment(resolver: .preview())
}
