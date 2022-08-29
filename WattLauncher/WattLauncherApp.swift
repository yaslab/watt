//
//  WattLauncherApp.swift
//  WattLauncher
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

@main
struct WattLauncherApp: App {
    @NSApplicationDelegateAdaptor
    private var delegate: WattLauncherAppDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
