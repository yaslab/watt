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
                .padding(.horizontal, 8)

            Section {
                AutoLaunchView()

                OpenSystemSettingsView()
            } header: {
                StatusBarMenuSectionHeader("Settings")
            }

            Divider()
                .padding(.horizontal, 8)

            Section {
                PiyotasoView()
            } header: {
                StatusBarMenuSectionHeader("Acknowledgments")
            }

            Divider()
                .padding(.horizontal, 8)

            Section {
                QuitView()
            }
        }
        .padding(8)
    }
}
