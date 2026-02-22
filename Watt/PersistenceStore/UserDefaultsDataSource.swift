//
//  UserDefaultsDataSource.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/18.
//

import Combine
import Foundation

nonisolated class UserDefaultsDataSource: PersistenceDataSource {
    private let defaults: UserDefaults

    init(_ defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func boolean(for key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func integer(for key: String) -> Int {
        defaults.integer(forKey: key)
    }

    func double(for key: String) -> Double {
        defaults.double(forKey: key)
    }

    func string(for key: String) -> String? {
        defaults.string(forKey: key)
    }

    func data(for key: String) -> Data? {
        defaults.data(forKey: key)
    }

    func set(_ value: Bool, for key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: Int, for key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: Double, for key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: String, for key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: Data, for key: String) {
        defaults.set(value, forKey: key)
    }

    func remove(for key: String) {
        defaults.removeObject(forKey: key)
    }

    var keys: some Collection<String> {
        defaults.dictionaryRepresentation().keys
    }

    func onChangePublisher() -> AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification, object: defaults)
            .map { _ in () }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
