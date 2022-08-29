//
//  WattAppController.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

class WattAppController {
    private lazy var ps = PowerSource()
    private lazy var launcherManager = LauncherManager()
    private lazy var statusItemManager = StatusItemManager(self, ps, launcherManager)

    func closeWindow() {
        guard let window = NSApp.windows.first else {
            return
        }
        window.close()
    }

    func setupStatusItem() {
        statusItemManager.setup()
    }

    @objc func onQuit() {
        NSApp.terminate(nil)
    }
}
