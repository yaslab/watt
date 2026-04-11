//
//  PowerSource.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

// Documentation:
// https://developer.apple.com/documentation/iokit/iopowersources_h

import func CoreFoundation.CFArrayGetCount
import func CoreFoundation.CFArrayGetValueAtIndex
import typealias CoreFoundation.CFTypeRef
import func IOKit.ps.IOPSCopyExternalPowerAdapterDetails
import func IOKit.ps.IOPSCopyPowerSourcesInfo
import func IOKit.ps.IOPSCopyPowerSourcesList
import func IOKit.ps.IOPSGetBatteryWarningLevel
import func IOKit.ps.IOPSGetPowerSourceDescription
import func IOKit.ps.IOPSGetProvidingPowerSourceType
import func IOKit.ps.IOPSGetTimeRemainingEstimate

public struct PowerSource {
    private init() {}

    // MARK: - Quick Power Source Info

    public static var timeRemainingEstimate: TimeRemainingEstimate {
        TimeRemainingEstimate(rawValue: IOPSGetTimeRemainingEstimate())
    }

    // MARK: - Power Source Descriptions

    public static func externalPowerAdapterDetails() -> ExternalPowerAdapterDetails? {
        guard let details = IOPSCopyExternalPowerAdapterDetails()?.takeRetainedValue() else {
            return nil
        }
        return ExternalPowerAdapterDetails(from: details)
    }

    public static func powerSources() -> [PowerSourceDescription]? {
        guard let info = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else {
            return nil
        }

        guard let list = IOPSCopyPowerSourcesList(info)?.takeRetainedValue() else {
            return nil
        }

        var descriptions: [PowerSourceDescription] = []
        for i in 0 ..< CFArrayGetCount(list) {
            let source = Unmanaged<CFTypeRef>.fromOpaque(CFArrayGetValueAtIndex(list, i)).takeUnretainedValue()
            guard let description = IOPSGetPowerSourceDescription(info, source)?.takeUnretainedValue() else {
                return nil
            }
            descriptions.append(PowerSourceDescription(from: description))
        }
        return descriptions
    }

    public static func providingPowerSourceType() -> ProvidingPowerSourceType? {
        guard let info = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else {
            return nil
        }

        guard let type = IOPSGetProvidingPowerSourceType(info)?.takeRetainedValue() else {
            return nil
        }

        return ProvidingPowerSourceType(rawValue: type as String)
    }

    // MARK: - Low Power Warnings

    public static var batteryWarningLevel: LowBatteryWarningLevel {
        LowBatteryWarningLevel(rawValue: IOPSGetBatteryWarningLevel())
    }
}
