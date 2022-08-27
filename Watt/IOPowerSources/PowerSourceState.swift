//
//  PowerSourceState.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSACPowerValue
import var IOKit.ps.kIOPSBatteryPowerValue
import var IOKit.ps.kIOPSOffLineValue

public struct PowerSourceState: RawRepresentable, Equatable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension PowerSourceState {
    public static let acPower = PowerSourceState(rawValue: kIOPSACPowerValue)
    public static let batteryPower = PowerSourceState(rawValue: kIOPSBatteryPowerValue)
    public static let offline = PowerSourceState(rawValue: kIOPSOffLineValue)
}
