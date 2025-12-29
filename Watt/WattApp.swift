//
//  WattApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

@main
struct WattApp: App {
    @State private var adapter: PowerAdapter

    init() {
        let client: PowerAdapterClient = liveResolver.resolve()
        _adapter = State(initialValue: client.value)
    }

    var body: some Scene {
        MenuBarExtra {
            StatusBarMenu(adapter: adapter)
        } label: {
            StatusBarButton(adapter: $adapter)
        }
        .menuBarExtraStyle(.window)
    }
}
