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
            var temp = source.menuOpenCount

            if temp < 0 {
                temp = 0
            }

            temp += 1

            if temp >= 200 {
                temp = 100
            }

            source.menuOpenCount = temp

            return temp
        }

        shouldRequestReview =
            if count == 5 || count == 30 || count == 100 {
                true
            } else {
                false
            }
    }
}
