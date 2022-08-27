//
//  WattAppDelegate.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Cocoa

class WattAppDelegate: NSObject, NSApplicationDelegate {
    private lazy var controller = WattAppController()
    
    // MARK: - Launching Applications
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        controller.closeWindow()
    }
    
    // MARK: - Terminating Applications
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
}
