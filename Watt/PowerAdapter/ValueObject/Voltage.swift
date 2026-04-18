//
//  Voltage.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/11.
//

import Foundation

/// The voltage in `mV`.
struct Voltage: RawRepresentable {
    let rawValue: Int
}

extension Voltage {
    func format() -> String {
        let voltage = Double(rawValue) / 1000.0
        return voltage.formatted(.number.precision(.fractionLength(0 ... 2))) + "V"
    }
}
