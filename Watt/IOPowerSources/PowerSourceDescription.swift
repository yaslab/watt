//
//  PowerSourceDescriptionn.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

// import class Foundation.NSDictionary

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

    public func value<T>(forKey key: PowerSourceDescription.Key<T>) -> T {
        dictionary[key.rawValue] as! T
    }

    public func value<T>(forKey key: PowerSourceDescription.Key<T?>) -> T? {
        dictionary[key.rawValue] as? T
    }

    public func value<T: RawRepresentable>(forKey key: PowerSourceDescription.Key<T>) -> T where T.RawValue == String {
        let value = dictionary[key.rawValue] as! String
        return T(rawValue: value)!
    }
}

extension PowerSourceDescription {
    public struct Key<ValueType>: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension PowerSourceDescription.Key {
    public typealias _Key = PowerSourceDescription.Key

    public static var powerSourceID: _Key<Int> { .init(rawValue: kIOPSPowerSourceIDKey) }
    public static var powerSourceState: _Key<PowerSourceState> { .init(rawValue: kIOPSPowerSourceStateKey) }
    public static var currentCapacity: _Key<Int> { .init(rawValue: kIOPSCurrentCapacityKey) }
    public static var maxCapacity: _Key<Int> { .init(rawValue: kIOPSMaxCapacityKey) }
    public static var designCapacity: _Key<Int?> { .init(rawValue: kIOPSDesignCapacityKey) }
    public static var nominalCapacity: _Key<Int?> { .init(rawValue: kIOPSNominalCapacityKey) }
    public static var timeToEmpty: _Key<Int?> { .init(rawValue: kIOPSTimeToEmptyKey) }
    public static var timeToFullCharge: _Key<Int?> { .init(rawValue: kIOPSTimeToFullChargeKey) }
    public static var isCharging: _Key<Bool> { .init(rawValue: kIOPSIsChargingKey) }
    public static var internalFailure: _Key<Bool?> { .init(rawValue: kIOPSInternalFailureKey) }
    public static var isPresent: _Key<Bool> { .init(rawValue: kIOPSIsPresentKey) }
    public static var voltage: _Key<Int?> { .init(rawValue: kIOPSVoltageKey) }
    public static var current: _Key<Int?> { .init(rawValue: kIOPSCurrentKey) }
    public static var temperature: _Key<Int?> { .init(rawValue: kIOPSTemperatureKey) }
    public static var name: _Key<String> { .init(rawValue: kIOPSNameKey) }
    public static var type: _Key<PowerSourceType> { .init(rawValue: kIOPSTypeKey) }
    public static var transportType: _Key<TransportType> { .init(rawValue: kIOPSTransportTypeKey) }
    public static var vendorID: _Key<Int?> { .init(rawValue: kIOPSVendorIDKey) }
    public static var productID: _Key<Int?> { .init(rawValue: kIOPSProductIDKey) }
    public static var vendorData: _Key<[AnyHashable: Any]?> { .init(rawValue: kIOPSVendorDataKey) }
    public static var batteryHealth: _Key<String?> { .init(rawValue: kIOPSBatteryHealthKey) }
    public static var batteryHealthCondition: _Key<String?> { .init(rawValue: kIOPSBatteryHealthConditionKey) }
    public static var batteryFailureModes: _Key<[String]?> { .init(rawValue: kIOPSBatteryFailureModesKey) }
    public static var healthConfidence: _Key<String?> { .init(rawValue: kIOPSHealthConfidenceKey) }
    public static var maxError: _Key<Int?> { .init(rawValue: kIOPSMaxErrKey) }
    public static var isCharged: _Key<Bool> { .init(rawValue: kIOPSIsChargedKey) }
    public static var isFinishingCharge: _Key<Bool?> { .init(rawValue: kIOPSIsFinishingChargeKey) }
    public static var hardwareSerialNumber: _Key<String?> { .init(rawValue: kIOPSHardwareSerialNumberKey) }
}
