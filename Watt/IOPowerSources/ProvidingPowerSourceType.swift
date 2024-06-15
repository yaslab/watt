//
//  ProvidingPowerSourceType.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPMACPowerKey
import var IOKit.ps.kIOPMBatteryPowerKey
import var IOKit.ps.kIOPMUPSPowerKey

public struct ProvidingPowerSourceType: RawRepresentable, Sendable, Equatable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ProvidingPowerSourceType {
    public static let ac = ProvidingPowerSourceType(rawValue: kIOPMACPowerKey)
    public static let battery = ProvidingPowerSourceType(rawValue: kIOPMBatteryPowerKey)
    public static let ups = ProvidingPowerSourceType(rawValue: kIOPMUPSPowerKey)
}
