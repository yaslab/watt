//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarMenu: View {
    @Environment(\.powerAdapterClient) private var powerAdapterClient

    var body: some View {
        let adapter = powerAdapterClient.value

        List {
            Section {
                PowerAdapterHeaderView()

                if adapter.isAdapterConnected {
                    PowerAdapterInformationView()
                }
            }

            Section("Settings") {
                AutoLaunchView()

                OpenSystemSettingsView()
            }

            Section("Acknowledgments") {
                PiyotasoView()
            }

            Section {
                QuitView(action: { NSApp.terminate(nil) })
            }
        }
        .listStyle(.plain)
        .fixedSize(horizontal: false, vertical: true)
    }
}
