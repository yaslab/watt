//
//  WattLauncherApp.swift
//  WattLauncher
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit

@main
enum WattLauncherApp {
    static func main() {
        let delegate = WattLauncherAppDelegate()
        NSApplication.shared.delegate = delegate
        _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    }
}
