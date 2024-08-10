//
//  WattAppController.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

final class WattAppController {
    @MainActor
    func closeWindows() {
        for window in NSApp.windows {
            window.close()
        }
    }

    @MainActor
    @objc func onQuit() {
        NSApp.terminate(nil)
    }
}
