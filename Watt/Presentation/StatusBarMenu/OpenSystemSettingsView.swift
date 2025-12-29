//
//  OpenSystemSettingsView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/08.
//

import SwiftUI

struct OpenSystemSettingsView: View {
    @Environment(\.launcherClient) private var launcherClient

    var body: some View {
        StatusBarMenuButton("Open System Settings", systemImage: "gear") {
            launcherClient.openSystemSettingsLoginItems()
        }
    }
}

#Preview {
    OpenSystemSettingsView()
}
