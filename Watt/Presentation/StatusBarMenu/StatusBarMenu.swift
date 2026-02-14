//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarMenu: View {
    @Environment(PowerAdapterModel.self) private var powerAdapterModel

    var body: some View {
        let adapter = powerAdapterModel.value

        VStack(alignment: .leading) {
            Section {
                PowerAdapterInformationView(adapter: adapter)
            } header: {
                StatusBarMenuSectionHeader("Power Adapter")
            }

            Divider()

            Section {
                PowerSourceInformationView(sources: adapter.sources)
            } header: {
                StatusBarMenuSectionHeader("Power Source")
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

#if DEBUG
    #Preview {
        StatusBarMenu()
            .environment(resolver: .preview())
    }
#endif
