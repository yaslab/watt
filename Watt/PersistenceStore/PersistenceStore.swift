//
//  PersistenceStore.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

import Synchronization

@dynamicMemberLookup
class PersistenceStore<Source: PersistenceDataSource>: Sendable {
    private let source: Mutex<Source>

    init(source: sending Source) {
        self.source = Mutex(source)
    }

    func withLock<Result, E>(
        _ body: (inout sending Source) throws(E) -> sending Result
    ) throws(E) -> sending Result where E: Error, Result: ~Copyable {
        return try source.withLock(body)
    }

    subscript<R>(dynamicMember keyPath: KeyPath<Source, R>) -> R {
        source.withLock { @MainActor in $0[keyPath: keyPath] }
    }
}
