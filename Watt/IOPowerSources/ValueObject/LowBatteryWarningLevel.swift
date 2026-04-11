//
//  LowBatteryWarningLevel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct IOKit.ps.IOPSLowBatteryWarningLevel
import var IOKit.ps.kIOPSLowBatteryWarningEarly
import var IOKit.ps.kIOPSLowBatteryWarningFinal
import var IOKit.ps.kIOPSLowBatteryWarningNone

public struct LowBatteryWarningLevel: RawRepresentable, Sendable, Equatable {
    public let rawValue: IOPSLowBatteryWarningLevel

    public init(rawValue: IOPSLowBatteryWarningLevel) {
        self.rawValue = rawValue
    }
}

extension LowBatteryWarningLevel {
    public static let none = LowBatteryWarningLevel(rawValue: kIOPSLowBatteryWarningNone)
    public static let early = LowBatteryWarningLevel(rawValue: kIOPSLowBatteryWarningEarly)
    public static let final = LowBatteryWarningLevel(rawValue: kIOPSLowBatteryWarningFinal)
}
