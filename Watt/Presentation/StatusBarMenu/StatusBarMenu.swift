//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import StoreKit
import SwiftUI

struct StatusBarMenu: View {
    @Environment(PowerAdapterModel.self) private var powerAdapterModel
    @Environment(ReviewRequestModel.self) private var reviewRequestModel
    @Environment(\.requestReview) private var requestReview

    var body: some View {
        content()
            .onAppear {
                reviewRequestModel.recordMenuOpen()
            }
            .onDisappear {
                if reviewRequestModel.shouldRequestReview {
                    requestReview()
                }
            }
    }

    private func content() -> some View {
        let adapter = powerAdapterModel.value

        return VStack(alignment: .leading) {
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
                GitHubView()
                PiyotasoView()
            } header: {
                StatusBarMenuSectionHeader("About Watt")
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
