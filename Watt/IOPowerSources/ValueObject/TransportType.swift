//
//  TransportType.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import var IOKit.ps.kIOPSInternalType
import var IOKit.ps.kIOPSNetworkTransportType
import var IOKit.ps.kIOPSSerialTransportType
import var IOKit.ps.kIOPSUSBTransportType

public struct TransportType: RawRepresentable, Sendable, Equatable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension TransportType {
    public static let serial = TransportType(rawValue: kIOPSSerialTransportType)
    public static let usb = TransportType(rawValue: kIOPSUSBTransportType)
    public static let network = TransportType(rawValue: kIOPSNetworkTransportType)
    public static let `internal` = TransportType(rawValue: kIOPSInternalType)
}
