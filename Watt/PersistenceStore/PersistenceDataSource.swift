//
//  PersistenceDataSource.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/18.
//

import Combine
import Foundation

nonisolated protocol PersistenceDataSource {
    func boolean(for key: String) -> Bool
    func integer(for key: String) -> Int
    func double(for key: String) -> Double
    func string(for key: String) -> String?
    func data(for key: String) -> Data?

    func set(_ value: Bool, for key: String)
    func set(_ value: Int, for key: String)
    func set(_ value: Double, for key: String)
    func set(_ value: String, for key: String)
    func set(_ value: Data, for key: String)

    func remove(for key: String)

    associatedtype Keys: Collection<String>
    var keys: Keys { get }

    func onChangePublisher() -> AnyPublisher<Void, Never>
}
