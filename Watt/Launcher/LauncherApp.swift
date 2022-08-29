//
//  LauncherApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/30.
//

import Foundation

struct LauncherApp {
    private let path = "Contents/Library/LoginItems/"

    private let name = "WattLauncher.app"

    private let bundle: Bundle

    init() {
        bundle = Bundle(
            url: Bundle.main.bundleURL
                .appendingPathComponent(path, isDirectory: true)
                .appendingPathComponent(name, isDirectory: true)
        )!
    }

    var id: String {
        bundle.bundleIdentifier!
    }
}
