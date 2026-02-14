//
//  WattApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

private let liveResolver: DIResolver = .live()

@main
struct WattApp: App {
    var body: some Scene {
        MenuBarExtra {
            StatusBarMenu()
                .environment(resolver: liveResolver)
        } label: {
            StatusBarButton()
                .environment(resolver: liveResolver)
        }
        .menuBarExtraStyle(.window)
    }
}
