//
//  LauncherManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import Foundation
import ServiceManagement

protocol LauncherManager: AnyObject {
    var isEnabled: Bool { get }
    var isRequiresApproval: Bool { get }

    func register() throws
    func unregister() throws

    func openSystemSettingsLoginItems()
}

enum LauncherManagerHelper {
    static func makeManager() -> LauncherManager {
        let launcherApp = LauncherApp()
        return SMAppService.loginItem(identifier: launcherApp.id)
    }
}

extension SMAppService: LauncherManager {
    var isEnabled: Bool {
        status == .enabled
    }

    var isRequiresApproval: Bool {
        status == .requiresApproval
    }

    func openSystemSettingsLoginItems() {
        SMAppService.openSystemSettingsLoginItems()
    }
}
