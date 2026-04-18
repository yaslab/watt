//
//  AutoStartManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import ServiceManagement

protocol AutoStartManager {
    var status: SMAppService.Status { get }

    func register() throws
    func unregister() throws
    func openSystemSettingsLoginItems()
}

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
