//
//  TimeRemainingEstimate.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct Foundation.TimeInterval

import var IOKit.ps.kIOPSTimeRemainingUnknown
import var IOKit.ps.kIOPSTimeRemainingUnlimited

public struct TimeRemainingEstimate: RawRepresentable, Equatable {
    public let rawValue: TimeInterval

    public init(rawValue: Double) {
        self.rawValue = rawValue
    }
}

extension TimeRemainingEstimate {
    public static let unlimited = TimeRemainingEstimate(rawValue: kIOPSTimeRemainingUnlimited)
    public static let unknown = TimeRemainingEstimate(rawValue: kIOPSTimeRemainingUnknown)
}
