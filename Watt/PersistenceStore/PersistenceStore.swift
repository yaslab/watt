//
//  PersistenceStore.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

import os

@dynamicMemberLookup
class PersistenceStore: Sendable {
    typealias Source = any PersistenceDataSource

    private let source: OSAllocatedUnfairLock<Source>

    init(source: sending Source) {
        self.source = OSAllocatedUnfairLock(uncheckedState: source)
    }

    func withLock<R: Sendable>(_ body: @Sendable (inout Source) throws -> R) rethrows -> R {
        try source.withLock { try body(&$0) }
    }

    // Note: For the reason why `keyPath` conforms to `Sendable`, see [SE-0418](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0418-inferring-sendable-for-methods.md).
    subscript<R: Sendable>(dynamicMember keyPath: KeyPath<Source, R> & Sendable) -> R {
        source.withLock { $0[keyPath: keyPath] }
    }
}
