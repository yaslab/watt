//
//  WattAppDelegate.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

class WattAppDelegate: NSObject, NSApplicationDelegate {
    private let container = DIContainer()

    private lazy var controller: WattAppController = container.resolve()
    private lazy var statusItemManager: StatusItemManager = container.resolve()

    // MARK: - Launching Applications

    func applicationDidFinishLaunching(_ notification: Notification) {
        controller.closeWindows()
        statusItemManager.setup()
    }

    // MARK: - Terminating Applications

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    // MARK: - Dummy

    @objc func onDummy() {
        assertionFailure("This method should not be called.")
    }
}
