//
//  WattApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

@main
struct WattApp: App {
    @Environment(\.powerAdapterClient) private var powerAdapterClient

    var body: some Scene {
        MenuBarExtra {
            StatusBarMenu(adapter: powerAdapterClient.value)
        } label: {
            StatusBarButton()
        }
        .menuBarExtraStyle(.window)
    }
}
