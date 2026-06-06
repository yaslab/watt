//
//  PersistenceDataSource+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/22.
//

import Combine
import Foundation

class PersistenceDataSourcePreviewImpl: PersistenceDataSource {
    private var storage: [String: Any]
    private let subject = PassthroughSubject<Void, Never>()

    init(_ storage: [String: Any] = [:]) {
        self.storage = storage
    }

    isolated deinit {
        subject.send(completion: .finished)
    }

    func boolean(for key: String) -> Bool {
        return storage[key] as? Bool ?? false
    }

    func integer(for key: String) -> Int {
        return storage[key] as? Int ?? 0
    }

    func double(for key: String) -> Double {
        return storage[key] as? Double ?? 0.0
    }

    func string(for key: String) -> String? {
        return storage[key] as? String
    }

    func data(for key: String) -> Data? {
        return storage[key] as? Data
    }

    func set(_ value: Bool, for key: String) {
        storage[key] = value
        subject.send()
    }

    func set(_ value: Int, for key: String) {
        storage[key] = value
        subject.send()
    }

    func set(_ value: Double, for key: String) {
        storage[key] = value
        subject.send()
    }

    func set(_ value: String, for key: String) {
        storage[key] = value
        subject.send()
    }

    func set(_ value: Data, for key: String) {
        storage[key] = value
        subject.send()
    }

    func remove(for key: String) {
        if storage.removeValue(forKey: key) != nil {
            subject.send()
        }
    }

    var keys: some Collection<String> {
        storage.keys
    }

    func onChangePublisher() -> AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }
}
