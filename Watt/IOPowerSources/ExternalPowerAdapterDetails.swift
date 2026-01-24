//
//  ExternalPowerAdapterDetails.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class CoreFoundation.CFDictionary
import var IOKit.ps.kIOPSNameKey
import var IOKit.ps.kIOPSPowerAdapterCurrentKey
import var IOKit.ps.kIOPSPowerAdapterFamilyKey
import var IOKit.ps.kIOPSPowerAdapterIDKey
import var IOKit.ps.kIOPSPowerAdapterRevisionKey
import var IOKit.ps.kIOPSPowerAdapterSerialNumberKey
import var IOKit.ps.kIOPSPowerAdapterSourceKey
import var IOKit.ps.kIOPSPowerAdapterWattsKey
import var IOKit.ps.kIOPSVoltageKey

public struct ExternalPowerAdapterDetails {
    let dictionary: [String: Any]

    init(from dictionary: CFDictionary) {
        self.dictionary = dictionary as! [String: Any]
    }
}

extension ExternalPowerAdapterDetails {
    func optionalValue<T>(forKey key: String) -> T? {
        guard let value = dictionary[key] else {
            return nil
        }
        return value as? T
    }

    public var id: Int? { optionalValue(forKey: kIOPSPowerAdapterIDKey) }
    public var watts: Int? { optionalValue(forKey: kIOPSPowerAdapterWattsKey) }
    public var revision: Int? { optionalValue(forKey: kIOPSPowerAdapterRevisionKey) }
    public var serialNumber: Int? { optionalValue(forKey: kIOPSPowerAdapterSerialNumberKey) }
    public var family: Int? { optionalValue(forKey: kIOPSPowerAdapterFamilyKey) }
    public var current: Int? { optionalValue(forKey: kIOPSPowerAdapterCurrentKey) }
    public var source: Int? { optionalValue(forKey: kIOPSPowerAdapterSourceKey) }

    // Undocumented
    public var voltage: Int? { optionalValue(forKey: kIOPSVoltageKey) }
    public var adapterVoltage: Int? { optionalValue(forKey: "AdapterVoltage") }
    public var name: String? { optionalValue(forKey: kIOPSNameKey) }
    public var manufacturer: String? { optionalValue(forKey: "Manufacturer") }
}
