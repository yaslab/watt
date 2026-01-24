//
//  PowerSourceNotification+Name.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSNotifyAnyPowerSource
import var IOKit.ps.kIOPSNotifyAttach
import var IOKit.ps.kIOPSNotifyPowerSource
import var IOKit.ps.kIOPSNotifyTimeRemaining

extension PowerSourceNotification {
    public struct Name: RawRepresentable, Sendable, Equatable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static let timeRemaining = Name(rawValue: kIOPSNotifyTimeRemaining)
        public static let powerSource = Name(rawValue: kIOPSNotifyPowerSource)
        public static let attach = Name(rawValue: kIOPSNotifyAttach)
        public static let any = Name(rawValue: kIOPSNotifyAnyPowerSource)
    }
}
