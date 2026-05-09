//
//  AutoStartManager+Live.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/05/09.
//

import ServiceManagement

class AutoStartManagerLiveImpl: AutoStartManager {
    private let service: SMAppService

    init(service: SMAppService = .mainApp) {
        self.service = service
    }

    var status: SMAppService.Status {
        return service.status
    }

    func register() throws {
        try service.register()
    }

    func unregister() throws {
        try service.unregister()
    }

    func openSystemSettingsLoginItems() {
        type(of: service).openSystemSettingsLoginItems()
    }
}
