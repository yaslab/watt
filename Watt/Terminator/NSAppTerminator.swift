//
//  NSAppTerminator.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/04/12.
//

import AppKit

class NSAppTerminator: Terminator {
    func terminate() {
        NSApp.terminate(nil)
    }
}
