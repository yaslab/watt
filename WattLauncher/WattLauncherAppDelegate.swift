//
//  WattLauncherAppDelegate.swift
//  WattLauncher
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit
import os

private let log = Logger(subsystem: "net.yaslab.watt.launcher", category: "App")

final class WattLauncherAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        for window in NSApp.windows {
            window.close()
        }

        Task { @MainActor in
            launchMainApp {
                NSApp.terminate(nil)
            }
        }
    }

    private func launchMainApp(callback: @escaping () -> Void) {
        log.debug("begin")

        let thisAppBundle = Bundle.main
        let thisAppID = thisAppBundle.bundleIdentifier!

        guard let index = thisAppID.lastIndex(of: ".") else {
            log.debug("no dot in bundle id")
            return
        }

        let mainAppID = String(thisAppID[..<index])

        let runningApps = NSRunningApplication.runningApplications(withBundleIdentifier: mainAppID)

        guard runningApps.isEmpty else {
            log.debug("the main app is running (\(runningApps.count))")
            return
        }

        let mainAppURL = thisAppBundle.bundleURL
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
            log.debug("no main app name in path")
            return
        }

        log.debug("launching")

        NSWorkspace.shared.openApplication(at: mainAppURL, configuration: .init()) { runningApp, error in
            if let error {
                log.debug("\(error.localizedDescription)")
            } else {
                log.debug("launched")
            }

            callback()
        }
    }
}
