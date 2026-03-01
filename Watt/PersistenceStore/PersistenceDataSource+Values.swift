//
//  PersistenceDataSource+Values.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/18.
//

private nonisolated struct PersistenceKeys {
    static let menuOpenCount = "Watt.menuOpenCount"
    static let isInitialAutoStartSetupCompleted = "Watt.isInitialAutoStartSetupCompleted"
}

nonisolated extension PersistenceDataSource {
    var menuOpenCount: Int {
        get { integer(for: PersistenceKeys.menuOpenCount) }
        set { set(newValue, for: PersistenceKeys.menuOpenCount) }
    }

    var isInitialAutoStartSetupCompleted: Bool {
        get { boolean(for: PersistenceKeys.isInitialAutoStartSetupCompleted) }
        set { set(newValue, for: PersistenceKeys.isInitialAutoStartSetupCompleted) }
    }
}
