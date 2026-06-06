//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import StoreKit
import SwiftUI

struct StatusBarMenu: View {
    @Environment(WattConfiguration.self) private var configuration
    @Environment(PowerAdapterModel.self) private var powerAdapterModel
    @Environment(ReviewRequestModel.self) private var reviewRequestModel
    @Environment(InputEventModel.self) private var inputEventModel
    @Environment(\.requestReview) private var requestReview

    var body: some View {
        content()
            .onAppear {
                reviewRequestModel.recordMenuOpen()
                inputEventModel.syncWithCurrentModifierFlags()
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
                StatusBarMenuSectionHeader(.menuPowerAdapter) {
                    if inputEventModel.isOptionKeyPressed, let dictionary = adapter.dictionary {
                        CopyAsJSONButton(dictionary: dictionary)
                    }
                }
            }

            ForEach(adapter.sources) { source in
                Divider()

                Section {
                    PowerSourceInformationView(source: source)
                } header: {
                    StatusBarMenuSectionHeader(.menuPowerSource) {
                        if inputEventModel.isOptionKeyPressed {
                            CopyAsJSONButton(dictionary: source.dictionary)
                        }
                    }
                }
            }

            Divider()

            Section {
                AutoStartView()
                OpenSystemSettingsView()
            } header: {
                StatusBarMenuSectionHeader(.menuSettings)
            }

            Divider()

            Section {
                GitHubView()
                PiyotasoView()
            } header: {
                StatusBarMenuSectionHeader(.menuAboutWatt) {
                    Text(configuration.formattedVersion())
                }
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
