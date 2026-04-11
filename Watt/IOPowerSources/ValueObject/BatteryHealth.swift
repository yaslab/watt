//
//  BatteryHealth.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/03/28.
//

import var IOKit.ps.kIOPSFairValue
import var IOKit.ps.kIOPSGoodValue
import var IOKit.ps.kIOPSPoorValue

public struct BatteryHealth: RawRepresentable, Sendable, Equatable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension BatteryHealth {
    public static let good = BatteryHealth(rawValue: kIOPSGoodValue)
    public static let fair = BatteryHealth(rawValue: kIOPSFairValue)
    public static let poor = BatteryHealth(rawValue: kIOPSPoorValue)
}
