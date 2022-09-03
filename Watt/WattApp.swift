//
//  WattApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

@main
struct WattApp: App {
    @NSApplicationDelegateAdaptor
    private var delegate: WattAppDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
