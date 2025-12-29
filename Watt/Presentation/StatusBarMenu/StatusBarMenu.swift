//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarMenu: View {
    let adapter: PowerAdapter

    var body: some View {
        VStack(alignment: .leading) {
            Section {
                PowerAdapterHeaderView(adapter: adapter)

                if adapter.isAdapterConnected {
                    PowerAdapterInformationView(adapter: adapter)
                }
            }

            Divider()

            Section {
                AutoLaunchView()

                OpenSystemSettingsView()
            } header: {
                StatusBarMenuSectionHeader("Settings")
            }

            Divider()

            Section {
                PiyotasoView()
            } header: {
                StatusBarMenuSectionHeader("Acknowledgments")
            }

            Divider()

            Section {
                QuitView()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
