//
//  AutoStartModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import Observation
import ServiceManagement

@Observable
class AutoStartModel {
    private let manager: AutoStartManager
    private var status: SMAppService.Status

    init(manager: AutoStartManager) {
        self.manager = manager
        self.status = manager.status
    }

    var isEnabled: Bool {
        return status == .enabled
    }

    var isRequiresApproval: Bool {
        return status == .requiresApproval
    }

    func register() throws {
        try manager.register()
        fetchStatus()
    }

    func unregister() async throws {
        try await manager.unregister()
        fetchStatus()
    }

    func openSystemSettingsLoginItems() {
        manager.openSystemSettingsLoginItems()
    }

    func fetchStatus() {
        status = manager.status
    }
}

extension AutoStartModel {
    func onChange(enabled: Bool) {
        Task {
            do {
                if enabled {
                    try register()
                } else {
                    try await unregister()
                }
            } catch {
                fetchStatus()
            }
        }
    }
}
