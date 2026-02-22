//
//  ReviewRequestModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

import Foundation
import Observation

@Observable
class ReviewRequestModel {
    private let persistenceStore: PersistenceStore

    init(persistenceStore: PersistenceStore) {
        self.persistenceStore = persistenceStore
    }

    private(set) var shouldRequestReview: Bool = false

    func recordMenuOpen() {
        let count = persistenceStore.withLock { source in
            if source.menuOpenCount < 0 {
                source.menuOpenCount = 0
            }

            source.menuOpenCount += 1

            if source.menuOpenCount == 200 {
                source.menuOpenCount = 100
            }

            return source.menuOpenCount
        }

        shouldRequestReview = {
            if count == 5 || count == 30 || count == 100 { return true }
            return false
        }()
    }
}
