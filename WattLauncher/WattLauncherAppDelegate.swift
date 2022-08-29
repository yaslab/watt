//
//  WattLauncherAppDelegate.swift
//  WattLauncher
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit
import os

private let log = Logger(subsystem: "net.yaslab.watt.launcher", category: "App")

class WattLauncherAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        for window in NSApp.windows {
            window.close()
        }

        log.debug("begin")

        let thisAppBundle = Bundle.main
        let thisAppID = thisAppBundle.bundleIdentifier!

        guard let index = thisAppID.lastIndex(of: ".") else {
            log.debug("no dot in bundle id")
            NSApp.terminate(nil)
            return
        }

        let mainAppID = String(thisAppID[..<index])

        let runningApps = NSRunningApplication.runningApplications(withBundleIdentifier: mainAppID)

        guard runningApps.isEmpty else {
            log.debug("the main app is running (\(runningApps.count))")
            NSApp.terminate(nil)
            return
        }

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
            log.debug("no main app name in path")
            NSApp.terminate(nil)
            return
        }

        let config = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.openApplication(at: mainAppURL, configuration: config) { _, error in
            if let error = error {
                log.debug("\(error.localizedDescription)")
            } else {
                log.debug("launched")
            }

            NSApp.terminate(nil)
        }

        log.debug("launching")
    }
}
