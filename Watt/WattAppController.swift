//
//  WattAppController.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

class WattAppController {
    func closeWindows() {
        for window in NSApp.windows {
            window.close()
        }
    }

    @objc func onQuit() {
        NSApp.terminate(nil)
    }
}
