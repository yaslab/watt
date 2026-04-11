//
//  PowerSourceType.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSInternalBatteryType
import var IOKit.ps.kIOPSUPSType

public struct PowerSourceType: RawRepresentable, Sendable, Equatable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension PowerSourceType {
    public static let ups = PowerSourceType(rawValue: kIOPSUPSType)
    public static let internalBattery = PowerSourceType(rawValue: kIOPSInternalBatteryType)
}
