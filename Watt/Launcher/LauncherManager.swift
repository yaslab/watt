//
//  LauncherManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit
import ServiceManagement

enum LauncherManager {
    private static let launcherAppBundle: Bundle = {
        let launcherAppName = "WattLauncher.app"
        let launcherAppURL = Bundle.main
            .bundleURL
            .appendingPathComponent("Contents", isDirectory: true)
            .appendingPathComponent("Library", isDirectory: true)
            .appendingPathComponent("LoginItems", isDirectory: true)
            .appendingPathComponent(launcherAppName, isDirectory: true)
        return Bundle(url: launcherAppURL)!
    }()

    private static var launcherAppID: String {
        launcherAppBundle.bundleIdentifier!
    }

    static var isEnabled: Bool {
        let apps = NSRunningApplication.runningApplications(withBundleIdentifier: launcherAppID)
        return !apps.isEmpty
    }

    static func setEnabled(_ enabled: Bool) -> Bool {
        SMLoginItemSetEnabled(launcherAppID as CFString, enabled)
    }
}
