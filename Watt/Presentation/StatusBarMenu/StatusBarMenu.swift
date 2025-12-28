//
//  StatusBarMenu.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import Combine
import SwiftUI

struct StatusBarMenu: View {
    @Environment(\.powerAdapterClient) private var powerAdapterClient

    @State private var adapter: PowerAdapter

    init(adapter: PowerAdapter) {
        _adapter = State(initialValue: adapter)
    }

    var body: some View {
        List {
            Section {
                PowerAdapterHeaderView(adapter: adapter)

                if adapter.isAdapterConnected {
                    PowerAdapterInformationView(adapter: adapter)
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
        .task {
            let publisher = powerAdapterClient.publisher
                .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)

            for await newValue in publisher.values {
                adapter = newValue
            }
        }
    }
}
