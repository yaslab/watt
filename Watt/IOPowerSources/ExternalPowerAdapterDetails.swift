//
//  ExternalPowerAdapterDetails.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSPowerAdapterCurrentKey
import var IOKit.ps.kIOPSPowerAdapterFamilyKey
import var IOKit.ps.kIOPSPowerAdapterIDKey
import var IOKit.ps.kIOPSPowerAdapterRevisionKey
import var IOKit.ps.kIOPSPowerAdapterSerialNumberKey
import var IOKit.ps.kIOPSPowerAdapterSourceKey
import var IOKit.ps.kIOPSPowerAdapterWattsKey

import var IOKit.ps.kIOPSNameKey
import var IOKit.ps.kIOPSVoltageKey

public struct ExternalPowerAdapterDetails {
    let dictionary: [String: Any]

    public func value<T>(forKey key: ExternalPowerAdapterDetails.Key<T>) -> T {
        dictionary[key.rawValue] as! T
    }
}

extension ExternalPowerAdapterDetails {
    public struct Key<ValueType>: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension ExternalPowerAdapterDetails.Key {
    public typealias _Key = ExternalPowerAdapterDetails.Key

    public static var id: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterIDKey) }
    public static var watts: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterWattsKey) }
    public static var revision: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterRevisionKey) }
    public static var serialNumber: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterSerialNumberKey) }
    public static var family: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterFamilyKey) }
    public static var current: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterCurrentKey) }
    public static var source: _Key<Int?> { .init(rawValue: kIOPSPowerAdapterSourceKey) }

    // Undocumented
    public static var voltage: _Key<Int?> { .init(rawValue: kIOPSVoltageKey) }
    public static var adapterVoltage: _Key<Int?> { .init(rawValue: "AdapterVoltage") }
    public static var name: _Key<String?> { .init(rawValue: kIOPSNameKey) }
    public static var manufacturer: _Key<String?> { .init(rawValue: "Manufacturer") }
}
