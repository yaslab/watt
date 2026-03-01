//
//  ReviewRequestModelTests.swift
//  WattTests
//
//  Created by Yasuhiro Hatta on 2026/03/01.
//

import Testing

@testable import Watt

struct ReviewRequestModelTests {

    @Test(arguments: [
        (4, 4, false),
        (5, 5, true),
        (29, 29, false),
        (30, 30, true),
        (99, 99, false),
        (100, 100, true),
        (199, 199, false),
        (200, 100, true),
        (201, 101, false),
        (300, 100, true),
        (301, 101, false),
    ])
    func recordMenuOpen(loopCount: Int, expectedCount: Int, expectedReviewFlag: Bool) async throws {
        // Arrange
        let store = PersistenceStore(
            source: PersistenceDataSourcePreviewImpl()
        )
        let model = ReviewRequestModel(persistenceStore: store)

        // Act
        for _ in 0 ..< loopCount {
            model.recordMenuOpen()
        }

        // Assert
        store.withLock { source in
            #expect(source.menuOpenCount == expectedCount)
        }
        #expect(model.shouldRequestReview == expectedReviewFlag)
    }

}
