//
//  LauncherClient.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import ServiceManagement

import protocol SwiftUI.EnvironmentKey
import struct SwiftUI.EnvironmentValues

class LauncherClient {
    private let service: SMAppService

    init(service: SMAppService) {
        self.service = service
    }

    var isEnabled: Bool {
        return service.status == .enabled
    }

    var isRequiresApproval: Bool {
        return service.status == .requiresApproval
    }

    func register() throws {
        try service.register()
    }

    func unregister() async throws {
        try await service.unregister()
    }

    func openSystemSettingsLoginItems() {
        SMAppService.openSystemSettingsLoginItems()
    }
}

// MARK: - Environment

private struct _Key: EnvironmentKey {
    static var defaultValue: LauncherClient = liveResolver.resolve()
}

extension EnvironmentValues {
    var launcherClient: LauncherClient {
        get { self[_Key.self] }
        set { self[_Key.self] = newValue }
    }
}
