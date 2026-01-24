//
//  PowerSourceDescription.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class CoreFoundation.CFDictionary
import var IOKit.ps.kIOPSBatteryFailureModesKey
import var IOKit.ps.kIOPSBatteryHealthConditionKey
import var IOKit.ps.kIOPSBatteryHealthKey
import var IOKit.ps.kIOPSCurrentCapacityKey
import var IOKit.ps.kIOPSCurrentKey
import var IOKit.ps.kIOPSDesignCapacityKey
import var IOKit.ps.kIOPSHardwareSerialNumberKey
import var IOKit.ps.kIOPSHealthConfidenceKey  // DEPRECATED
import var IOKit.ps.kIOPSInternalFailureKey
import var IOKit.ps.kIOPSIsChargedKey
import var IOKit.ps.kIOPSIsChargingKey
import var IOKit.ps.kIOPSIsFinishingChargeKey
import var IOKit.ps.kIOPSIsPresentKey
import var IOKit.ps.kIOPSMaxCapacityKey
import var IOKit.ps.kIOPSMaxErrKey
import var IOKit.ps.kIOPSNameKey
import var IOKit.ps.kIOPSNominalCapacityKey
import var IOKit.ps.kIOPSPowerSourceIDKey
import var IOKit.ps.kIOPSPowerSourceStateKey
import var IOKit.ps.kIOPSProductIDKey
import var IOKit.ps.kIOPSTemperatureKey
import var IOKit.ps.kIOPSTimeToEmptyKey
import var IOKit.ps.kIOPSTimeToFullChargeKey
import var IOKit.ps.kIOPSTransportTypeKey
import var IOKit.ps.kIOPSTypeKey
import var IOKit.ps.kIOPSVendorDataKey
import var IOKit.ps.kIOPSVendorIDKey
import var IOKit.ps.kIOPSVoltageKey

public struct PowerSourceDescription {
    let dictionary: [String: Any]

    init(from dictionary: CFDictionary) {
        self.dictionary = dictionary as! [String: Any]
    }
}

extension PowerSourceDescription {
    func value<T>(forKey key: String) -> T {
        return dictionary[key] as! T
    }

    func optionalValue<T>(forKey key: String) -> T? {
        guard let value = dictionary[key] else {
            return nil
        }
        return value as? T
    }

    public var powerSourceID: Int { value(forKey: kIOPSPowerSourceIDKey) }
    public var powerSourceState: PowerSourceState { PowerSourceState(rawValue: value(forKey: kIOPSPowerSourceStateKey)) }
    public var currentCapacity: Int { value(forKey: kIOPSCurrentCapacityKey) }
    public var maxCapacity: Int { value(forKey: kIOPSMaxCapacityKey) }
    public var designCapacity: Int? { optionalValue(forKey: kIOPSDesignCapacityKey) }
    public var nominalCapacity: Int? { optionalValue(forKey: kIOPSNominalCapacityKey) }
    public var timeToEmpty: Int? { optionalValue(forKey: kIOPSTimeToEmptyKey) }
    public var timeToFullCharge: Int? { optionalValue(forKey: kIOPSTimeToFullChargeKey) }
    public var isCharging: Bool { value(forKey: kIOPSIsChargingKey) }
    public var internalFailure: Bool? { optionalValue(forKey: kIOPSInternalFailureKey) }
    public var isPresent: Bool { value(forKey: kIOPSIsPresentKey) }
    public var voltage: Int? { optionalValue(forKey: kIOPSVoltageKey) }
    public var current: Int? { optionalValue(forKey: kIOPSCurrentKey) }
    public var temperature: Int? { optionalValue(forKey: kIOPSTemperatureKey) }
    public var name: String { value(forKey: kIOPSNameKey) }
    public var type: PowerSourceType { PowerSourceType(rawValue: value(forKey: kIOPSTypeKey)) }
    public var transportType: TransportType { TransportType(rawValue: value(forKey: kIOPSTransportTypeKey)) }
    public var vendorID: Int? { optionalValue(forKey: kIOPSVendorIDKey) }
    public var productID: Int? { optionalValue(forKey: kIOPSProductIDKey) }
    public var vendorData: [AnyHashable: Any]? { optionalValue(forKey: kIOPSVendorDataKey) }
    public var batteryHealth: String? { optionalValue(forKey: kIOPSBatteryHealthKey) }
    public var batteryHealthCondition: String? { optionalValue(forKey: kIOPSBatteryHealthConditionKey) }
    public var batteryFailureModes: [String]? { optionalValue(forKey: kIOPSBatteryFailureModesKey) }
    public var healthConfidence: String? { optionalValue(forKey: kIOPSHealthConfidenceKey) }
    public var maxError: Int? { optionalValue(forKey: kIOPSMaxErrKey) }
    public var isCharged: Bool { value(forKey: kIOPSIsChargedKey) }
    public var isFinishingCharge: Bool? { optionalValue(forKey: kIOPSIsFinishingChargeKey) }
    public var hardwareSerialNumber: String? { optionalValue(forKey: kIOPSHardwareSerialNumberKey) }
}
