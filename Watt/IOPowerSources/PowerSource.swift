//
//  PowerSource.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

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

public class PowerSource {
    private var _snapshot: CFTypeRef?

    public init() {}

    // MARK: - Quick Power Source Info

    public var timeRemainingEstimate: TimeRemainingEstimate {
        TimeRemainingEstimate(rawValue: IOPSGetTimeRemainingEstimate())
    }

    // MARK: - Power Source Descriptions

    public func externalPowerAdapterDetails() -> ExternalPowerAdapterDetails? {
        guard let details = IOPSCopyExternalPowerAdapterDetails()?.takeRetainedValue() else {
            return nil
        }
        return ExternalPowerAdapterDetails(dictionary: details as! [String: Any])
    }

    public func powerSources(snapshot: Bool = false) -> [PowerSourceDescription]? {
        let info: CFTypeRef
        if snapshot {
            guard let _snapshot else {
                return nil
            }
            info = _snapshot
        } else {
            guard let blob = getinfo() else {
                return nil
            }
            info = blob
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
            descriptions.append(PowerSourceDescription(dictionary: description as! [String: Any]))
        }

        return descriptions
    }

    public func providingPowerSourceType(snapshot: Bool = false) -> ProvidingPowerSourceType? {
        let info: CFTypeRef?
        if snapshot {
            guard let _snapshot else {
                return nil
            }
            info = _snapshot
        } else {
            info = nil
        }

        guard let type = IOPSGetProvidingPowerSourceType(info)?.takeRetainedValue() else {
            return nil
        }
        return ProvidingPowerSourceType(rawValue: type as String)
    }

    public func takeSnapshot() -> Bool {
        guard let blob = getinfo() else {
            return false
        }
        _snapshot = blob
        return true
    }

    private func getinfo() -> CFTypeRef? {
        IOPSCopyPowerSourcesInfo()?.takeRetainedValue()
    }

    // MARK: - Low Power Warnings

    public var batteryWarningLevel: LowBatteryWarningLevel {
        LowBatteryWarningLevel(rawValue: IOPSGetBatteryWarningLevel())
    }
}
