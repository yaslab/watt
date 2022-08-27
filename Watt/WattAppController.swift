//
//  WattAppController.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Cocoa

class WattAppController {
    func closeWindow() {
        guard let window = NSApp.windows.first else {
            return
        }
        window.close()
    }
}
