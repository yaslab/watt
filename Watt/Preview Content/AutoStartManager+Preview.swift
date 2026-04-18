//
//  AutoStartManager+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import ServiceManagement

class AutoStartManagerPreviewImpl: AutoStartManager {
    let status: SMAppService.Status

    init(status: SMAppService.Status = .enabled) {
        self.status = status
    }

    func register() throws {}

    func unregister() throws {}

    func openSystemSettingsLoginItems() {}
}
