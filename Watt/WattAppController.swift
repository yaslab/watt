//
//  WattAppController.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Cocoa

class WattAppController {
    private lazy var ps = PowerSource()
    private lazy var statusItemManager = StatusItemManager(self, ps)

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
