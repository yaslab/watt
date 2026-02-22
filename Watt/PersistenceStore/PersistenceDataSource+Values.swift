//
//  PersistenceDataSource+Values.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/18.
//

private nonisolated struct PersistenceKeys {
    static let test = "test"
}

nonisolated extension PersistenceDataSource {
    var test: Int {
        get { integer(for: PersistenceKeys.test) }
        set { set(newValue, for: PersistenceKeys.test) }
    }
}
