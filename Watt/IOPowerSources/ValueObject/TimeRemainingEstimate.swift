//
//  TimeRemainingEstimate.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct CoreFoundation.CFTimeInterval
import var IOKit.ps.kIOPSTimeRemainingUnknown
import var IOKit.ps.kIOPSTimeRemainingUnlimited

public struct TimeRemainingEstimate: RawRepresentable, Sendable, Equatable {
    public let rawValue: CFTimeInterval

    public init(rawValue: CFTimeInterval) {
        self.rawValue = rawValue
    }
}

extension TimeRemainingEstimate {
    public static let unlimited = TimeRemainingEstimate(rawValue: kIOPSTimeRemainingUnlimited)
    public static let unknown = TimeRemainingEstimate(rawValue: kIOPSTimeRemainingUnknown)
}
