//
//  ExternalPowerAdapterDetails+HVC.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/15.
//

import Foundation

// HVC (High Voltage Charging)
extension ExternalPowerAdapterDetails {
    // Note: If PD is not supported, the value will be 255.
    public var usbHvcIndex: Int? { optionalValue(forKey: "UsbHvcHvcIndex") }

    public var usbHvcMenu: [UsbHvcMenuItem]? {
        guard let array = dictionary["UsbHvcMenu"] as? [[String: Any]] else {
            return nil
        }
        return array.compactMap {
            UsbHvcMenuItem(from: $0)
        }
        .sorted(by: { $0.index < $1.index })
    }
}

extension ExternalPowerAdapterDetails {
    public struct UsbHvcMenuItem: Sendable {
        public let index: Int
        public let maxCurrent: Int
        public let maxVoltage: Int

        init?(from dictionary: [String: Any]) {
            guard let index = dictionary["Index"] as? Int else {
                return nil
            }
            guard let maxCurrent = dictionary["MaxCurrent"] as? Int else {
                return nil
            }
            guard let maxVoltage = dictionary["MaxVoltage"] as? Int else {
                return nil
            }

            self.index = index
            self.maxCurrent = maxCurrent
            self.maxVoltage = maxVoltage
        }
    }
}

extension ExternalPowerAdapterDetails.UsbHvcMenuItem: Identifiable {
    public var id: Int {
        return index
    }
}
