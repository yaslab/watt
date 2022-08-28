//
//  WattLauncherAppDelegate.swift
//  WattLauncher
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit

class WattLauncherAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let mainAppURL = Bundle.main.bundleURL
            // Drop `WattLauncher.app`
            .deletingLastPathComponent()
            // Drop `LoginItems`
            .deletingLastPathComponent()
            // Drop `Library`
            .deletingLastPathComponent()
            // Drop `Contents`
            .deletingLastPathComponent()

        let mainAppName = "Watt.app"

        guard mainAppURL.lastPathComponent == mainAppName else {
            // The main app is not exist.
            // This happens when this app is not in the main bundle (e.g. debug run).
            NSApp.terminate(nil)
            return
        }

        let mainAppBundle = Bundle(url: mainAppURL)!
        let mainAppID = mainAppBundle.bundleIdentifier!

        let apps = NSRunningApplication.runningApplications(withBundleIdentifier: mainAppID)

        guard apps.isEmpty else {
            return
        }

        Task { @MainActor in
            let config = NSWorkspace.OpenConfiguration()
            _ = try await NSWorkspace.shared.openApplication(at: mainAppURL, configuration: config)
        }
    }
}
