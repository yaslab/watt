//
//  NotificationName.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSNotifyAnyPowerSource
import var IOKit.ps.kIOPSNotifyAttach
import var IOKit.ps.kIOPSNotifyPowerSource
import var IOKit.ps.kIOPSNotifyTimeRemaining

extension PowerSource {
    public struct NotificationName: RawRepresentable, Sendable, Equatable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static let timeRemaining = NotificationName(rawValue: kIOPSNotifyTimeRemaining)
        public static let powerSource = NotificationName(rawValue: kIOPSNotifyPowerSource)
        public static let attach = NotificationName(rawValue: kIOPSNotifyAttach)
        public static let any = NotificationName(rawValue: kIOPSNotifyAnyPowerSource)
    }
}
