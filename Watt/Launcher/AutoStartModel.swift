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
    private let persistenceStore: PersistenceStore
    private let manager: AutoStartManager
    private var status: SMAppService.Status

    init(persistenceStore: PersistenceStore, manager: AutoStartManager) {
        self.persistenceStore = persistenceStore
        self.manager = manager
        self.status = manager.status
    }

    var isEnabled: Bool {
        get { status == .enabled }
        set { onChange(enabled: newValue) }
    }

    func register() throws {
        try manager.register()
        fetchStatus()
    }

    func unregister() throws {
        try manager.unregister()
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
    func setup() {
        if persistenceStore.isInitialAutoStartSetupCompleted {
            return
        }

        do {
            try register()
        } catch {
            fetchStatus()
        }

        persistenceStore.withLock { source in
            source.isInitialAutoStartSetupCompleted = true
        }
    }

    private func onChange(enabled: Bool) {
        do {
            if enabled {
                try register()
            } else {
                try unregister()
            }
        } catch {
            fetchStatus()
        }
    }
}
