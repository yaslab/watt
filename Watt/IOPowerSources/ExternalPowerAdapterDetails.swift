//
//  ExternalPowerAdapterDetails.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class Foundation.NSDictionary
import var IOKit.ps.kIOPSPowerAdapterCurrentKey
import var IOKit.ps.kIOPSPowerAdapterFamilyKey
import var IOKit.ps.kIOPSPowerAdapterIDKey
import var IOKit.ps.kIOPSPowerAdapterRevisionKey
import var IOKit.ps.kIOPSPowerAdapterSerialNumberKey
import var IOKit.ps.kIOPSPowerAdapterSourceKey
import var IOKit.ps.kIOPSPowerAdapterWattsKey

public struct ExternalPowerAdapterDetails {
    let dictionary: NSDictionary

    init(from dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
}

extension ExternalPowerAdapterDetails {
    func optionalValue<T>(forKey key: String) -> T? {
        guard let _value = dictionary[key] else {
            return nil
        }
        let value = _value as? T
        assert(value != nil)
        return value!
    }

    /// This key refers to the attached external AC power adapter's ID. The value associated with this key is a integer.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var id: Int? { optionalValue(forKey: kIOPSPowerAdapterIDKey) }

    /// This key refers to the wattage of the external AC power adapter attached to a portable. The value associated with this key is a integer value, in units of watts.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var watts: Int? { optionalValue(forKey: kIOPSPowerAdapterWattsKey) }

    /// The power adapter's revision. The value associated with this key is a integer value.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var revision: Int? { optionalValue(forKey: kIOPSPowerAdapterRevisionKey) }

    /// The power adapter's serial number. The value associated with this key is a integer value.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var serialNumber: Int? { optionalValue(forKey: kIOPSPowerAdapterSerialNumberKey) }

    /// The power adapter's family code. The value associated with this key is a integer value.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var family: Int? { optionalValue(forKey: kIOPSPowerAdapterFamilyKey) }

    /// This key refers to the current of the external AC power adapter attached to a portable. The value associated with this key is a integer value, in units of mAmps.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var current: Int? { optionalValue(forKey: kIOPSPowerAdapterCurrentKey) }

    /// This key refers to the source of the power. The value associated with this key is a integer value.
    ///
    /// This key may be present in the dictionary returned from `IOPSCopyExternalPowerAdapterDetails`. This key might not be defined in the adapter details dictionary.
    public var source: Int? { optionalValue(forKey: kIOPSPowerAdapterSourceKey) }

    // MARK: Undocumented

    public var voltage: Int? { optionalValue(forKey: "Voltage") ?? optionalValue(forKey: "AdapterVoltage") }
    public var name: String? { optionalValue(forKey: "Name") }
    public var manufacturer: String? { optionalValue(forKey: "Manufacturer") }
}
